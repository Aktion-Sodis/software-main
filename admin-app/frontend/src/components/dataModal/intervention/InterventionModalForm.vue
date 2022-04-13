<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2 v-if="edit">
        {{ $t('interventions.modal.modalTitle.edit') }}
        <i>
          {{
            calculateUILocaleString({
              languageTexts: interventionInFocus.name.languageTexts,
            })
          }}
        </i>
      </h2>
      <h2 v-else>
        {{ $t('interventions.modal.modalTitle.create') }}
      </h2>
    </v-card-title>
    <v-card-subtitle v-if="edit">
      {{ $t('interventions.modal.modalDescription.edit') }}
    </v-card-subtitle>
    <v-card-subtitle v-else>
      {{ $t('interventions.modal.modalDescription.create') }}
    </v-card-subtitle>

    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pb-0 px-0 px-sm-3">
            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('interventions.modal.name') }}
            </v-card-title>
            <LocaleTextBox
              labelPrefixI18nSelector="interventions.modal.name"
              :initVal="name"
              @res="nameUpdatedHandler"
              :key="rerenderNameLocaleTextBox"
            >
              <template v-slot:text-input="slotProps">
                <v-text-field
                  :label="slotProps.label"
                  v-model="slotProps.model"
                  autofocus
                  required
                  outlined
                  dense
                  @input="slotProps.inputHandler"
                ></v-text-field>
              </template>
            </LocaleTextBox>

            <v-card-title class="pt-4">
              {{ $t('interventions.modal.description') }}
            </v-card-title>
            <LocaleTextBox
              labelPrefixI18nSelector="interventions.modal.description"
              :initVal="description"
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

          <v-col cols="12" sm="6" class="pt-6 pt-sm-3 px-0 px-sm-3">
            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('interventions.type.title') }}:
              <v-btn-toggle v-model="typeIndex" mandatory class="ml-2">
                <v-tooltip top>
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn v-bind="attrs" v-on="on">
                      <v-icon>mdi-hammer-wrench</v-icon>
                    </v-btn>
                  </template>
                  <span>{{ $t('interventions.type.types.TECHNOLOGY') }}</span>
                </v-tooltip>
                <v-tooltip top>
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn v-bind="attrs" v-on="on">
                      <v-icon>mdi-school</v-icon>
                    </v-btn>
                  </template>
                  <span>{{ $t('interventions.type.types.EDUCATION') }}</span>
                </v-tooltip>
              </v-btn-toggle>
            </v-card-title>

            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('interventions.modal.image') }}
            </v-card-title>

            <ImgFromS3 :assumedSrc="assumedSrc" :key="rerenderImgFromS3" dataType="intervention">
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
        :disabled="!isSubmitDisabled"
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
import { Intervention, InterventionType } from '../../../models';

import LocaleTextBox from '../../commons/LocaleTextBox.vue';
import FileInput from '../../commons/FileInput.vue';
import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'InterventionModalForm',
  components: { LocaleTextBox, FileInput, ImgFromS3 },
  data() {
    return {
      id: null,
      name: emptyMutableI18nString(),
      typeIndex: 0,
      types: [InterventionType.TECHNOLOGY, InterventionType.EDUCATION],
      description: emptyMutableI18nString(),
      levelIds: [],
      rerenderImgFromS3: false,
      rerenderNameLocaleTextBox: 0, // increment this
      rerenderDescriptionLocaleTextBox: -1, // decrement this
    };
  },
  watch: {
    dataDraft: 'prefillComponentDataFromDataDraft',
    imageFile() {
      this.rerenderImgFromS3 = !this.rerenderImgFromS3;
    },
  },
  mounted() {
    this.prefillComponentDataFromDataDraft();
  },
  computed: {
    ...mapGetters({
      dataModalMode: 'dataModal/getMode',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      dataDraft: 'dataModal/getDataDraft',
      imageFile: 'dataModal/getImageFile',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
      calculateLocalizedString: 'calculateLocalizedString',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    interventionInFocus() {
      return this.INTERVENTIONById({ id: this.dataIdInFocus });
    },
    // if not edit, it is definitely the create mode.
    edit() {
      return this.dataModalMode === modalModesDict.edit;
    },
    deriveImgPath() {
      return this.edit
        ? deriveFilePath('interventionPicPath', { interventionID: this.dataIdInFocus })
        : null;
    },
    assumedSrc() {
      return this.imageFile ?? this.deriveImgPath;
    },
    type() {
      return this.types[this.typeIndex];
    },
    isSubmitDisabled() {
      return (
        this.calculateLocalizedString({ languageTexts: this.name.languageTexts })
        !== this.$t('general.noTextProvided')
      );
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
      this.setDraft(
        new Intervention({
          name: this.name,
          description: this.description,
          interventionType: this.type,
          tags: [], // TODO
          surveys: [], // TODO
          levels: [],
          contents: this.contents, // TODO
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
