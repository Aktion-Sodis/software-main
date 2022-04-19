<template>
  <v-dialog v-model="isLevelModalDisplayed" max-width="1200px" persistent @keydown.esc="escHandler">
    <v-card class="px-0 pt-0 px-md-4 pt-md-4">
      <v-form lazy-validation>
        <v-card-title>
          <h2 v-if="edit && levelInFocus">
            {{ $t('organizationStructure.levelModal.modalTitle.edit') }}
            <i>{{ calculateUILocaleString({ languageTexts: levelInFocus.name.languageTexts }) }}</i>
          </h2>
          <h2 v-else-if="create">
            {{ $t('organizationStructure.levelModal.modalTitle.create') }}
          </h2>
          <h2 v-else-if="read">
            {{ $t('organizationStructure.levelModal.modalTitle.read') }}
          </h2>
        </v-card-title>
        <v-card-subtitle v-if="edit">
          {{ $t('organizationStructure.levelModal.modalDescription.edit') }}
        </v-card-subtitle>
        <v-card-subtitle v-else-if="create">
          {{ $t('organizationStructure.levelModal.modalDescription.create') }}
        </v-card-subtitle>

        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
                <v-card-title class="pt-0 pt-sm-2">
                  {{ $t('organizationStructure.levelModal.name') }}
                </v-card-title>
                <h2 v-if="read && levelInFocus">
                  {{ calculateUILocaleString({ languageTexts: levelInFocus.name.languageTexts }) }}
                </h2>
                <LocaleTextBox
                  v-else
                  :initVal="name"
                  labelPrefixI18nSelector="organizationStructure.levelModal.name"
                  @res="nameUpdatedHandler"
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
                <div
                  v-if="read && levelInFocus"
                  class="d-flex flex-column justify-center"
                  style="min-height: 10rem"
                >
                  <h3>
                    {{
                      calculateUILocaleString({
                        languageTexts: levelInFocus.description.languageTexts,
                      })
                    }}
                  </h3>
                </div>
                <LocaleTextBox
                  v-else
                  :initVal="description"
                  labelPrefixI18nSelector="organizationStructure.levelModal.description"
                  @res="descriptionUpdatedHandler"
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

                <div v-if="read && levelInFocus" style="min-height: 5rem">
                  <h3 v-if="levelInFocus.parentLevelID">
                    {{ $t('organizationStructure.levelModal.upperLevel') }}:
                    {{
                      calculateUILocaleString({
                        languageTexts: LEVELById({ id: levelInFocus.parentLevelID }).name
                          .languageTexts,
                      })
                    }}
                  </h3>
                </div>
              </v-col>

              <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
                <v-card-title class="pt-0 pt-sm-2">
                  <span>
                    {{ $t('organizationStructure.levelModal.interventions') }}
                  </span>
                  <div v-if="!read" class="ml-2">
                    <v-checkbox
                      v-model="areInterventionsAllowed"
                      :label="$t('organizationStructure.levelModal.areInterventionsAllowed')"
                    ></v-checkbox>
                  </div>
                </v-card-title>
                <div v-if="read && dataIdInFocus">
                  <div v-if="interventionsOfLevelById({ levelId: dataIdInFocus }).length > 0">
                    <div
                      v-for="intervention in interventionsOfLevelById({ levelId: dataIdInFocus })"
                      :key="intervention.id"
                    >
                      <v-avatar>
                        <v-icon>
                          {{
                            intervention.interventionType === InterventionType.TECHNOLOGY
                              ? 'mdi-hammer-wrench'
                              : 'mdi-school'
                          }}
                        </v-icon>
                      </v-avatar>
                      <span>
                        {{
                          calculateUILocaleString({
                            languageTexts: intervention.name.languageTexts,
                          })
                        }}
                      </span>
                    </div>
                  </div>
                  <div v-else>{{ $t('organizationStructure.hasNoInterventions') }}</div>
                </div>
                <v-tooltip bottom v-if="!read" :disabled="areInterventionsAllowed">
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

                <div v-if="!read">
                  <transition-group name="fade" tag="div">
                    <div
                      class="mb-2"
                      v-for="(customDatum, index) in customData"
                      :key="customDatum.id"
                    >
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
                          <v-btn-toggle
                            v-model="customDataTypeIndices[index]"
                            mandatory
                            class="ml-2"
                          >
                            <v-tooltip bottom>
                              <template v-slot:activator="{ on, attrs }">
                                <v-btn v-bind="attrs" v-on="on">
                                  <v-icon> {{ customDataTypesIconDict.INT }} </v-icon>
                                </v-btn>
                              </template>
                              <span>{{
                                $t('organizationStructure.levelModal.customData.types.INT')
                              }}</span>
                            </v-tooltip>
                            <v-tooltip bottom>
                              <template v-slot:activator="{ on, attrs }">
                                <v-btn v-bind="attrs" v-on="on">
                                  <v-icon> {{ customDataTypesIconDict.STRING }} </v-icon>
                                </v-btn>
                              </template>
                              <span>{{
                                $t('organizationStructure.levelModal.customData.types.STRING')
                              }}</span>
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
                <div v-else>
                  <div v-if="levelInFocus.customData.length > 0">
                    <div
                      v-for="customDatum in levelInFocus.customData"
                      :key="customDatum.id"
                      class="mb-2"
                    >
                      <div
                        class="rounded-lg pa-4 d-flex justify-space-between"
                        style="border: 1px solid; border-color: #736b5e; position: relative"
                      >
                        <div class="d-flex flex-column justify-space-between">
                          <h2 class="text-center mb-2">
                            {{ $t('organizationStructure.levelModal.customData.name') }}
                          </h2>
                          <span>
                            {{
                              calculateUILocaleString({
                                languageTexts: customDatum.name.languageTexts,
                              })
                            }}
                          </span>
                        </div>
                        <div class="d-flex flex-column">
                          <h2 class="text-center mb-2">
                            {{ $t('organizationStructure.levelModal.customData.type') }}
                          </h2>
                          <span>
                            {{
                              $t(
                                `organizationStructure.levelModal.customData.types.${
                                  customDataTypesDict[customDatum.type]
                                }`
                              )
                            }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div v-else>
                    {{ $t('organizationStructure.hasNoCustomData') }}
                  </div>
                </div>

                <!-- <v-card-title>
                  {{ $t('baseData.tags') }}
                </v-card-title>
                <div v-if="read && levelInFocus">
                  <v-chip v-for="tagId in levelInFocus.tagIds" :key="tagId">
                    {{
                      calculateUILocaleString({
                        languageTexts: tagById({ tagId }).name.languageTexts,
                      })
                    }}
                  </v-chip>
                </div>
                <v-select
                  v-else
                  v-model="tagIds"
                  :items="allLevelTags"
                  item-value="tagId"
                  item-text="name"
                  deletable-chips
                  chips
                  dense
                  :label="$t('baseData.tags')"
                  multiple
                  outlined
                ></v-select> -->
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>

        <v-card-actions>
          <v-btn x-large v-if="edit" @click="deleteHandler" color="warning" text>
            {{ $t('general.delete') }}
            <v-icon large> mdi-delete </v-icon>
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn x-large color="secondary" text @click="closeHandler">
            {{ read ? $t('general.close') : $t('general.cancel') }}
          </v-btn>
          <v-btn x-large v-if="read" color="primary" text @click="editHandler">
            {{ $t('general.edit') }}
          </v-btn>
          <v-btn
            x-large
            v-if="!read"
            type="submit"
            color="primary"
            text
            @click.prevent="submitHandler"
            :disabled="isFormInvalid"
          >
            {{ $t('general.save') }}
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';
import { modalModesDict, dataTypesDict, customDataTypesIconDict } from '../../lib/constants';
import LocaleTextBox from '../commons/form/LocaleTextBox.vue';
import { Level, InterventionType, Type } from '../../models';
import {
  emptyMutableCustomData,
  emptyMutableI18nString,
  mutableI18nString,
} from '../../lib/classes';
// import { emptyI18nString } from '../../store/classes';

const levelDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_LEVEL_DESCRIPTION_MAX_CHAR, 10),
  0,
);

export default {
  components: { LocaleTextBox },
  name: 'LevelModal',
  data() {
    return {
      levelDescriptionMaxChar,
      name: emptyMutableI18nString(),
      description: emptyMutableI18nString(),
      allowedInterventionIds: [],
      areInterventionsAllowed: true,
      InterventionType,
      customData: [],
      customDataTypeIndices: [0],
      customDataTypesIconDict,
      customDataTypesDict: Type,
      // tagIds: [],
    };
  },
  watch: {
    levelDraft: 'prefillComponentDataFromLevelDraft',
    // getMode(newValue) {
    //   if (newValue === modalModesDict.edit) this.prefillComponentDataFromLevelDraft();
    // },
  },
  computed: {
    ...mapGetters({
      interventions: 'INTERVENTION_Data/getInterventions',

      dataType: 'dataModal/getDataType',
      modalMode: 'dataModal/getMode',
      isModalDisplayed: 'dataModal/getIsDisplayed',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      levelDraft: 'dataModal/getDataDraft',

      // allLevelTags: 'LEVEL_Data/getLevelTags',
      // tagById: 'LEVEL_Data/tagById',
      lowestLevelId: 'LEVEL_Data/lowestLevelId',
      LEVELById: 'LEVEL_Data/LEVELById',
      fallbackLocaleIndex: 'fallbackLocaleIndex',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
      interventionsOfLevelById: 'LEVEL_Data/interventionsOfLevelById',
      nLevels: 'LEVEL_Data/nLevels',

      calculateUILocaleString: 'calculateUILocaleString',
    }),
    localizeInterventions() {
      return this.interventions.map((intervention) => ({
        ...intervention,
        name: intervention.name.languageTexts[this.$store.getters.fallbackLocaleIndex],
      }));
    },
    isLevelModalDisplayed() {
      return this.isModalDisplayed && this.dataType === dataTypesDict.level;
    },
    levelInFocus() {
      return this.LEVELById({ id: this.dataIdInFocus });
    },
    requiredi18n() {
      return this.$t('general.form.required');
    },
    maxCharExceededi18n() {
      return this.$t('general.form.maxCharExceeded', {
        maxChar: levelDescriptionMaxChar,
      });
    },
    isFormInvalid() {
      return !this.name.languageTexts[this.fallbackLocaleIndex];
    },
    edit() {
      return this.modalMode === modalModesDict.edit;
    },
    create() {
      return this.modalMode === modalModesDict.create;
    },
    read() {
      return this.modalMode === modalModesDict.read;
    },
    areThereChanges() {
      // const tagIdsInComponent = new Set(this.tagIds);
      // const tagIdsInDraft = new Set(this.levelDraft.tagIds);

      const allowedInterventionsInComponent = new Set(this.allowedInterventionIds);
      const allowedInterventionsInDraft = new Set(this.levelDraft.allowedInterventionIds);
      return (
        this.name !== this.levelDraft.name
        || this.description !== this.levelDraft.description
        // || !(
        // tagIdsInComponent.size === tagIdsInDraft.size
        // && [...tagIdsInComponent].every((value) => tagIdsInDraft.has(value))
        // )
        || !(
          allowedInterventionsInComponent.size === allowedInterventionsInDraft.size
          && [...allowedInterventionsInComponent].every((value) => allowedInterventionsInDraft.has(value))
        )
      );
    },
  },
  methods: {
    ...mapActions({
      saveData: 'dataModal/saveData',
      deleteData: 'dataModal/deleteData',
      abortReadData: 'dataModal/abortReadData',
      abortCreateData: 'dataModal/abortCreateData',
      abortEditData: 'dataModal/abortEditData',
      editData: 'dataModal/editData',

      showFeedbackForDuration: 'FEEDBACK_UI/showFeedbackForDuration',
    }),
    ...mapMutations({
      setDraft: 'dataModal/setDraft',
    }),
    deleteHandler() {
      if (this.read) return;
      if (this.dataIdInFocus !== this.lowestLevelId) {
        this.showFeedbackForDuration({
          type: 'warning',
          text: 'Only the lowest level can be deleted.',
        });
        return;
      }
      this.deleteData({ dataType: 'LEVEL' });
    },
    closeHandler() {
      if (this.read) this.abortReadData();
      else if (this.create) this.abortCreateData({ dataType: 'LEVEL' });
      else if (this.edit) this.abortEditData({ dataId: this.dataIdInFocus, dataType: 'LEVEL' });
    },
    editHandler() {
      this.editData({ dataId: this.dataIdInFocus, dataType: 'LEVEL' });
    },
    escHandler() {
      this.closeHandler();
    },
    async submitHandler() {
      let parentLevelID;
      if (this.nLevels === 0) parentLevelID = null;
      else parentLevelID = this.create ? this.lowestLevelId : this.levelInFocus.parentLevelID;

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
      const originalVersion = this.levelInFocus ? this.levelInFocus._version : 0;
      this.saveData({ dataType: 'LEVEL', originalVersion });
    },
    prefillComponentDataFromLevelDraft() {
      this.name = mutableI18nString({ languageTexts: this.levelDraft?.name.languageTexts });
      this.description = mutableI18nString({
        languageTexts: this.levelDraft?.description.languageTexts,
      });
      // this.tagIds = this.levelDraft?.tagIds ?? [];
      this.allowedInterventionIds = this.interventionsOfLevelById({ levelId: this.dataIdInFocus }).map((i) => i.id) ?? [];
      this.customData = Array.from(this.levelDraft?.customData ?? []);
      console.log(this.customData);
      this.customDataTypeIndices = Array.from(this.levelDraft?.customData.map((cd) => (cd.type === Type.INT ? 0 : 1))) ?? [];
      console.log(this.customDataTypeIndices);
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
.delete-custom-data-wrapper {
  position: absolute;
  right: -20px;
  top: -10px;
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
