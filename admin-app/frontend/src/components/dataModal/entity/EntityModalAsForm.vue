<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2 v-if="edit && entityInFocus">
        {{ $t('organizationStructure.entityModal.modalTitle.edit') }}
        <i>
          {{ calculateUILocaleString({ languageTexts: entityInFocus.name.languageTexts }) }}
        </i>
      </h2>
      <h2 v-else>
        {{ $t('organizationStructure.entityModal.modalTitle.create') }}
      </h2>
    </v-card-title>
    <v-card-subtitle v-if="edit">
      {{ $t('organizationStructure.entityModal.modalDescription.edit') }}
    </v-card-subtitle>
    <v-card-subtitle v-else>
      {{ $t('organizationStructure.entityModal.modalDescription.create') }}
    </v-card-subtitle>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pb-0 px-0 mb-3 px-sm-3">
            <LocaleTextBox
              labelPrefixI18nSelector="organizationStructure.entityModal.name"
              :initVal="name"
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

            <LocaleTextBox
              labelPrefixI18nSelector="organizationStructure.entityModal.description"
              :initVal="description"
              @res="descriptionUpdatedHandler"
              :key="rerenderDescriptionLocaleTextBox"
            >
              <template v-slot:text-input="slotProps">
                <v-textarea
                  :label="slotProps.label"
                  v-model="slotProps.model"
                  @input="slotProps.inputHandler"
                  required
                  outlined
                  dense
                ></v-textarea>
              </template>
            </LocaleTextBox>

            <v-select
              v-if="allEntitiesOfUpperLevel.length > 0"
              v-model="parentEntityID"
              :items="allEntitiesOfUpperLevel"
              item-value="id"
              :label="$t('organizationStructure.entityModal.upperEntityLabel')"
              dense
              outlined
              persistent-hint
            >
              <template v-slot:item="data">
                {{
                  calculateUILocaleString({
                    languageTexts: data.item.name.languageTexts,
                  })
                }}
              </template>
              <template v-slot:selection="data">
                {{
                  calculateUILocaleString({
                    languageTexts: data.item.name.languageTexts,
                  })
                }}
              </template>
            </v-select>
          </v-col>
          <v-col cols="12" sm="6" class="pb-0 px-0 mb-3 px-sm-3">
            <ImgFromS3 :assumedSrc="assumedSrc" :key="rerenderImgFromS3" dataType="entity">
              <template v-slot:v-img="slotProps">
                <v-img max-height="200px" :src="slotProps.src">
                  <v-btn fab class="iv-edit-icon" color="primary" @click="selectImg">
                    <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
                  </v-btn>

                  <FileInput ref="img-upload" style="display: none" :acceptedType="'image/png'" />
                </v-img>
              </template>
            </ImgFromS3>
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
import { emptyMutableI18nString, mutableI18nString } from '../../../lib/classes';
import { modalModesDict } from '../../../lib/constants';
import { deriveFilePath } from '../../../lib/utils';
import { Entity } from '../../../models';

import LocaleTextBox from '../../commons/form/LocaleTextBox.vue';
import FileInput from '../../commons/form/FileInput.vue';
import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'EntityModalAsForm',
  components: { LocaleTextBox, FileInput, ImgFromS3 },
  data() {
    return {
      name: emptyMutableI18nString(),
      description: emptyMutableI18nString(),
      parentEntityID: null,
      rerenderImgFromS3: false,
      rerenderNameLocaleTextBox: 0,
      rerenderDescriptionLocaleTextBox: -1,
    };
  },
  watch: {
    // dataDraft: 'prefillComponentDataFromDataDraft',
    imageFile() {
      this.rerenderImgFromS3 = !this.rerenderImgFromS3;
    },
  },
  mounted() {
    if (this.edit) this.prefillComponentDataFromDataDraft();
  },
  computed: {
    ...mapGetters({
      dataModalMode: 'dataModal/getMode',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      dataDraft: 'dataModal/getDataDraft',
      imageFile: 'dataModal/getImageFile',
      ENTITYById: 'ENTITY_Data/ENTITYById',
      allEntitiesOfLevel: 'ENTITY_Data/allEntitiesByLevelId',
      LEVELById: 'LEVEL_Data/LEVELById',
      calculateLocalizedString: 'calculateLocalizedString',
      calculateUILocaleString: 'calculateUILocaleString',
      getCreatingEntityInLevelId: 'getCreatingEntityInLevelId',
    }),
    entityInFocus() {
      return this.ENTITYById({ id: this.dataIdInFocus });
    },
    // if not edit, it is definitely the create mode.
    edit() {
      return this.dataModalMode === modalModesDict.edit;
    },
    deriveImgPath() {
      return this.edit ? deriveFilePath('entityPicPath', { entityID: this.dataIdInFocus }) : null;
    },
    assumedSrc() {
      return this.imageFile ?? this.deriveImgPath;
    },
    isSubmitDisabled() {
      return (
        this.calculateLocalizedString({ languageTexts: this.name.languageTexts })
          === this.$t('general.noTextProvided')
        || (this.allEntitiesOfUpperLevel.length > 0 && !this.parentEntityID)
      );
    },
    allEntitiesOfUpperLevel() {
      let id;
      if (this.edit) {
        id = this.dataDraft?.entityLevelId;
      } else {
        id = this.getCreatingEntityInLevelId;
      }
      const currentLevel = this.LEVELById({
        id,
      });
      if (!currentLevel) return [];
      return this.allEntitiesOfLevel({ entityLevelId: currentLevel.parentLevelID });
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
      // show error feedback here
      if (this.allEntitiesOfUpperLevel.length > 0 && this.parentEntityID === null) return;
      this.setDraft(
        new Entity({
          name: this.name,
          description: this.description,
          entityLevelId: this.edit
            ? this.entityInFocus.entityLevelId
            : this.getCreatingEntityInLevelId,
          parentEntityID: this.parentEntityID ?? null,
          appliedInterventions: [],
          customData: [], // TODO
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
      this.contents = this.dataDraft?.contents ?? [];
      this.parentEntityID = this.dataDraft?.parentEntityID;

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
