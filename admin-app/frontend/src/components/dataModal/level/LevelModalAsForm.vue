<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2 v-if="edit && levelInFocus">
        {{ $t('organizationStructure.levelModal.modalTitle.edit') }}
        <i>{{ calculateUILocaleString({ languageTexts: levelInFocus.name.languageTexts }) }}</i>
      </h2>
      <h2 v-else>
        {{ $t('organizationStructure.levelModal.modalTitle.create') }}
      </h2>
    </v-card-title>
    <v-card-subtitle v-if="edit">
      {{ $t('organizationStructure.levelModal.modalDescription.edit') }}
    </v-card-subtitle>
    <v-card-subtitle v-else>
      {{ $t('organizationStructure.levelModal.modalDescription.create') }}
    </v-card-subtitle>

    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('organizationStructure.levelModal.name') }}
            </v-card-title>
            <LocaleTextBox
              :initVal="name"
              labelPrefixI18nSelector="organizationStructure.levelModal.name"
              @res="nameUpdatedHandler"
              :key="rerenderNameLocaleTextBox"
            >
              <template v-slot:text-input="slotProps">
                <v-text-field
                  autofocus
                  required
                  outlined
                  dense
                  :label="slotProps.label"
                  v-model="slotProps.model"
                  @input="slotProps.inputHandler"
                ></v-text-field>
              </template>
            </LocaleTextBox>

            <v-card-title class="pt-4">
              {{ $t('organizationStructure.levelModal.description') }}
            </v-card-title>
            <LocaleTextBox
              :initVal="description"
              labelPrefixI18nSelector="organizationStructure.levelModal.description"
              @res="descriptionUpdatedHandler"
              :key="rerenderDescriptionLocaleTextBox"
            >
              <template v-slot:text-input="slotProps">
                <v-textarea
                  autofocus
                  required
                  outlined
                  dense
                  :label="slotProps.label"
                  v-model="slotProps.model"
                  @input="slotProps.inputHandler"
                ></v-textarea>
              </template>
            </LocaleTextBox>
          </v-col>

          <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
            <ImgFromS3 :assumedSrc="assumedSrc" :key="rerenderImgFromS3" dataType="level">
              <template v-slot:v-img="slotProps">
                <v-img max-height="200px" :src="slotProps.src">
                  <v-btn fab class="iv-edit-icon" color="primary" @click="selectImg">
                    <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
                  </v-btn>

                  <FileInput ref="img-upload" style="display: none" :acceptedType="'image/png'" />
                </v-img>
              </template>
            </ImgFromS3>

            <v-card-title class="pb-0 pt-sm-2">
              <span>
                {{ $t('organizationStructure.levelModal.interventions') }}
              </span>
              <div class="ml-2">
                <v-checkbox
                  v-model="areInterventionsAllowed"
                  :label="$t('organizationStructure.levelModal.areInterventionsAllowed')"
                ></v-checkbox>
              </div>
            </v-card-title>
            <v-tooltip bottom :disabled="areInterventionsAllowed">
              <template v-slot:activator="{ on, attrs }">
                <div v-bind="attrs" v-on="on">
                  <v-select
                    v-model="allowedInterventionIds"
                    :items="localizeInterventions"
                    :label="$t('organizationStructure.levelModal.manageAllowedInterventions')"
                    multiple
                    dense
                    outlined
                    persistent-hint
                    item-value="id"
                    item-text="name"
                    :disabled="!areInterventionsAllowed"
                  ></v-select>
                </div>
              </template>
              <span>
                {{ $t('organizationStructure.levelModal.allowInterventionsFirst') }}
              </span>
            </v-tooltip>

            <v-card-title class="pt-0 pt-sm-2">
              <span>
                {{ $t('organizationStructure.levelModal.customData.title') }}
              </span>
            </v-card-title>

            <div>
              <transition-group name="fade" tag="div">
                <div class="mb-2" v-for="(customDatum, index) in customData" :key="customDatum.id">
                  <div
                    class="rounded-lg pa-4 d-flex justify-space-between"
                    style="border: 1px solid; border-color: #736b5e; position: relative"
                  >
                    <div class="delete-custom-data-wrapper">
                      <v-btn small color="warning" fab @click="deleteCustomDatum(index)">
                        <v-icon>mdi-delete</v-icon>
                      </v-btn>
                    </div>
                    <div class="d-flex flex-column justify-space-between">
                      <h2 class="text-center mb-2">
                        {{ $t('organizationStructure.levelModal.customData.name') }}
                      </h2>
                      <LocaleTextBox
                        :initVal="customDatum.name"
                        labelPrefixI18nSelector=""
                        @res="(res) => customDataNameUpdatedHandler(res, index)"
                        class="mb-0"
                      >
                        <template v-slot:text-input="slotProps">
                          <v-text-field
                            autofocus
                            required
                            outlined
                            dense
                            :label="slotProps.label"
                            v-model="slotProps.model"
                            @input="slotProps.inputHandler"
                          ></v-text-field>
                        </template>
                      </LocaleTextBox>
                    </div>
                    <div class="d-flex flex-column">
                      <h2 class="text-center mb-2">
                        {{ $t('organizationStructure.levelModal.customData.type') }}
                      </h2>
                      <v-btn-toggle v-model="customDataTypeIndices[index]" mandatory class="ml-2">
                        <v-tooltip bottom>
                          <template v-slot:activator="{ on, attrs }">
                            <v-btn v-bind="attrs" v-on="on">
                              <v-icon> {{ customDataTypesIconDict.INT }} </v-icon>
                            </v-btn>
                          </template>
                          <span>
                            {{ $t('organizationStructure.levelModal.customData.types.INT') }}
                          </span>
                        </v-tooltip>
                        <v-tooltip bottom>
                          <template v-slot:activator="{ on, attrs }">
                            <v-btn v-bind="attrs" v-on="on">
                              <v-icon> {{ customDataTypesIconDict.STRING }} </v-icon>
                            </v-btn>
                          </template>
                          <span>
                            {{ $t('organizationStructure.levelModal.customData.types.STRING') }}
                          </span>
                        </v-tooltip>
                      </v-btn-toggle>
                    </div>
                  </div>
                </div>
              </transition-group>
              <div class="d-flex justify-center mt-2">
                <v-btn color="primary" x-large fab @click="addNewCustomDataHandler">
                  <v-icon>mdi-plus</v-icon>
                </v-btn>
              </div>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>

    <v-card-actions>
      <v-btn x-large v-if="edit" @click="deleteData" color="warning" text>
        {{ $t('general.delete') }}
        <v-icon large> mdi-delete </v-icon>
      </v-btn>
      <v-spacer></v-spacer>
      <v-btn x-large color="secondary" text @click="closeHandler">
        {{ $t('general.cancel') }}
      </v-btn>
      <v-btn
        x-large
        type="submit"
        color="primary"
        text
        @click.prevent="submitHandler"
        :disabled="isSubmitDisabled"
      >
        {{ $t('general.save') }}
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
import {
  emptyMutableCustomData,
  emptyMutableI18nString,
  mutableI18nString,
} from '../../../lib/classes';
import { modalModesDict, customDataTypesIconDict } from '../../../lib/constants';
import { deriveFilePath } from '../../../lib/utils';
import { Level, Type } from '../../../models';

import LocaleTextBox from '../../commons/form/LocaleTextBox.vue';
import FileInput from '../../commons/form/FileInput.vue';
import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'LevelModalAsForm',
  components: { LocaleTextBox, FileInput, ImgFromS3 },
  data() {
    return {
      name: emptyMutableI18nString(),
      description: emptyMutableI18nString(),
      allowedInterventionIds: [],
      areInterventionsAllowed: true,
      customData: [],
      customDataTypeIndices: [0],
      customDataTypesIconDict,
      customDataTypesDict: Type,
      rerenderImgFromS3: false,
      rerenderNameLocaleTextBox: 0,
      rerenderDescriptionLocaleTextBox: -1,
    };
  },
  mounted() {
    if (this.edit) this.prefillComponentDataFromDataDraft();
  },
  computed: {
    ...mapGetters({
      dataType: 'dataModal/getDataType',
      modalMode: 'dataModal/getMode',
      isModalDisplayed: 'dataModal/getIsDisplayed',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      dataDraft: 'dataModal/getDataDraft',
      imageFile: 'dataModal/getImageFile',

      lowestLevelId: 'LEVEL_Data/lowestLevelId',
      LEVELById: 'LEVEL_Data/LEVELById',
      nLevels: 'LEVEL_Data/nLevels',
      interventionsOfLevelById: 'LEVEL_Data/interventionsOfLevelById',

      interventions: 'INTERVENTION_Data/getInterventions',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',

      fallbackLocaleIndex: 'fallbackLocaleIndex',
      calculateLocalizedString: 'calculateLocalizedString',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    levelInFocus() {
      return this.LEVELById({ id: this.dataIdInFocus });
    },
    // if not edit, it is definitely the create mode.
    edit() {
      return this.modalMode === modalModesDict.edit;
    },
    deriveImgPath() {
      return this.edit ? deriveFilePath('levelPicPath', { levelID: this.dataIdInFocus }) : null;
    },
    assumedSrc() {
      return this.imageFile ?? this.deriveImgPath;
    },
    isSubmitDisabled() {
      return (
        this.calculateLocalizedString({ languageTexts: this.name.languageTexts })
        === this.$t('general.noTextProvided')
      );
    },
    localizeInterventions() {
      return this.interventions.map((intervention) => ({
        ...intervention,
        name: intervention.name.languageTexts[this.$store.getters.fallbackLocaleIndex],
      }));
    },
  },
  methods: {
    ...mapActions({
      saveData: 'dataModal/saveData',
      deleteData: 'dataModal/deleteData',
      abortCreateData: 'dataModal/abortCreateData',
      abortEditData: 'dataModal/abortEditData',
      editData: 'dataModal/editData',
    }),
    ...mapMutations({
      setDraft: 'dataModal/setDraft',
    }),
    closeHandler() {
      if (this.edit) this.abortEditData();
      else this.abortCreateData();
    },
    editHandler() {
      this.editData();
    },
    escHandler() {
      this.closeHandler();
    },
    async submitHandler() {
      let parentLevelID;
      if (this.nLevels === 0) parentLevelID = null;
      else parentLevelID = this.edit ? this.levelInFocus.parentLevelID : this.lowestLevelId;

      this.setDraft(
        new Level({
          name: this.name,
          description: this.description,
          parentLevelID,
          interventionsAreAllowed: this.areInterventionsAllowed,
          allowedInterventions: this.allowedInterventionIds || [],
          // tagIds: this.tagIds || [],
          tagIds: [],
          customData: this.customData.map((cd, i) => ({
            id: cd.id,
            name: cd.name,
            type: this.customDataTypeIndices[i] === 0 ? Type.INT : Type.STRING,
          })),
        }),
      );
      await this.$nextTick();
      this.saveData();
    },
    selectImg() {
      const imgInput = this.$refs['img-upload'];
      imgInput.$el.click();
    },
    prefillComponentDataFromDataDraft() {
      this.name = mutableI18nString({
        languageTexts: this.dataDraft?.name.languageTexts,
      });
      this.description = mutableI18nString({
        languageTexts: this.dataDraft?.description.languageTexts,
      });
      this.allowedInterventionIds = this.interventionsOfLevelById({ levelId: this.dataIdInFocus }).map((i) => i.id) ?? [];
      this.customData = this.dataDraft?.customData.map((cd) => ({
        id: cd.id,
        name: mutableI18nString(cd.name),
        type: cd.type,
      })) ?? [];
      this.customDataTypeIndices = Array.from(
        this.dataDraft?.customData.map((cd) => (cd.type === Type.INT ? 0 : 1)) ?? [],
      );

      // changing the keys so that the initVal prop retriggers.
      this.rerenderNameLocaleTextBox += 1;
      this.rerenderDescriptionLocaleTextBox -= 1;
    },
    nameUpdatedHandler(res) {
      this.name = res;
    },
    descriptionUpdatedHandler(res) {
      this.description = res;
    },
    customDataNameUpdatedHandler(res, index) {
      this.customData[index].name = mutableI18nString({ languageTexts: res.languageTexts });
    },
    addNewCustomDataHandler() {
      this.customData.push(emptyMutableCustomData());
    },
    deleteCustomDatum(index) {
      this.customData.splice(index, 1);
    },
  },
};
</script>

<style scoped>
.iv-edit-icon {
  position: absolute;
  top: 8px;
  right: 8px;
}
</style>
