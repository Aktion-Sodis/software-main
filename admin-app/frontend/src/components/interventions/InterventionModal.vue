<template>
  <v-dialog
    v-model="isInterventionModalDisplayed"
    max-width="1200px"
    persistent
    @keydown.esc="escHandler"
  >
    <v-card class="px-0 pt-0 px-md-4 pt-md-4">
      <v-form lazy-validation>
        <v-card-title>
          <h2 v-if="edit">
            {{ $t('interventions.interventionModal.modalTitle.edit') }}
            <i>
              {{
                calculateUILocaleString({
                  languageTexts: interventionInFocus.name.languageTexts,
                })
              }}
            </i>
          </h2>
          <h2 v-else-if="create">
            {{ $t('interventions.interventionModal.modalTitle.create') }}
          </h2>
          <h2 v-else>
            {{ $t('interventions.interventionModal.modalTitle.read') }}
          </h2>
        </v-card-title>
        <v-card-subtitle v-if="edit">
          {{ $t('interventions.interventionModal.modalDescription.edit') }}
        </v-card-subtitle>
        <v-card-subtitle v-else-if="create">
          {{ $t('interventions.interventionModal.modalDescription.create') }}
        </v-card-subtitle>

        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6" class="pb-0 px-0 px-sm-3">
                <v-card-title class="pt-0 pt-sm-2">
                  {{ $t('interventions.interventionModal.name') }}
                </v-card-title>
                <h2 v-if="read && interventionInFocus">
                  {{
                    calculateUILocaleString({
                      languageTexts: interventionInFocus.name.languageTexts,
                    })
                  }}
                </h2>
                <LocaleTextBox
                  v-else
                  labelPrefixI18nSelector="interventions.interventionModal.name"
                  @res="nameUpdatedHandler"
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
                  {{ $t('interventions.interventionModal.description') }}
                </v-card-title>
                <div
                  v-if="read && interventionInFocus"
                  class="d-flex flex-column justify-center"
                  style="min-height: 10rem"
                >
                  <h3>
                    {{
                      calculateUILocaleString({
                        languageTexts: interventionInFocus.description.languageTexts,
                      })
                    }}
                  </h3>
                </div>

                <LocaleTextBox
                  v-else
                  labelPrefixI18nSelector="interventions.interventionModal.description"
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
              </v-col>

              <v-col cols="12" sm="6" class="pt-6 pt-sm-3 px-0 px-sm-3">
                <v-card-title class="pt-0 pt-sm-2">
                  {{ $t('interventions.type.title') }}:

                  <div v-if="read && interventionInFocus">
                    <v-tooltip top>
                      <template v-slot:activator="{ on, attrs }">
                        <v-avatar v-bind="attrs" v-on="on">
                          <v-icon>{{
                            interventionInFocus.interventionType === InterventionType.TECHNOLOGY
                              ? 'mdi-hammer-wrench'
                              : 'mdi-school'
                          }}</v-icon>
                        </v-avatar>
                      </template>
                      <span>{{
                        $t(`interventions.type.types.${interventionInFocus.interventionType}`)
                      }}</span>
                    </v-tooltip>
                  </div>

                  <v-select
                    v-model="type"
                    class="mt-6"
                    outlined
                    dense
                    :items="Object.keys(InterventionType)"
                    v-else
                  >
                    <template v-slot:selection="data">
                      <v-icon>
                        {{
                          data.item === InterventionType.TECHNOLOGY
                            ? 'mdi-hammer-wrench'
                            : 'mdi-school'
                        }}
                      </v-icon>
                    </template>
                    <template v-slot:item="data">
                      {{ $t(`interventions.type.types.${data.item}`) }}
                    </template>
                  </v-select>
                </v-card-title>

                <v-card-title class="pt-0 pt-sm-2">
                  {{ $t('interventions.interventionModal.image') }}
                </v-card-title>

                <v-img src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg" max-height="200px">
                  <v-btn v-if="!read" fab class="iv-edit-icon" color="primary" @click="selectImg">
                    <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
                  </v-btn>
                  <input
                    v-if="!read"
                    type="file"
                    accept="image/png, image/jpeg"
                    ref="img-upload"
                    style="display: none"
                  />
                </v-img>

                <v-card-title>
                  {{ $t('baseData.tags') }}
                </v-card-title>

                <div v-if="read && interventionInFocus">
                  <v-chip v-for="tagId in interventionInFocus.tagIds" :key="tagId">
                    {{
                      calculateUILocaleString({
                        languageTexts: tagById({ tagId }).name,
                      })
                    }}
                  </v-chip>
                </div>
                <v-select
                  v-else
                  v-model="tagIds"
                  :items="allInterventionTags"
                  item-value="tagId"
                  deletable-chips
                  chips
                  dense
                  :label="$t('baseData.tags')"
                  multiple
                  outlined
                >
                  <template v-slot:selection="data">
                    {{
                      calculateUILocaleString({
                        languageTexts: data.item.text.languageTexts,
                      })
                    }}
                  </template>
                  <template v-slot:item="data">
                    {{
                      calculateUILocaleString({
                        languageTexts: data.item.text.languageTexts,
                      })
                    }}
                  </template>
                </v-select>

                <v-card-title>
                  {{ $t('baseData.documents') }}
                  <v-btn
                    v-if="!read"
                    fab
                    x-small
                    color="primary lighten-2"
                    class="ml-2"
                    @click="showToBeImplementedFeedback"
                  >
                    <v-icon dark> mdi-plus </v-icon>
                  </v-btn>
                </v-card-title>
                <v-expansion-panels
                  accordion
                  v-if="interventionInFocus && allDocumentsOfIntervention.length > 0"
                >
                  <v-expansion-panel v-for="doc in allDocumentsOfIntervention" :key="doc.id">
                    <v-expansion-panel-header outlined>
                      <div class="d-flex justify-start">
                        <v-icon> mdi-file-document-outline </v-icon>
                        <p class="mb-0 pt-1 ml-2 text-subtitle-1">
                          {{ doc.name }}
                        </p>
                      </div>
                    </v-expansion-panel-header>
                    <v-expansion-panel-content>
                      <p style="transform: translateY(-12px)" class="mb-0">
                        {{ doc.description }}
                      </p>
                      <v-chip v-for="tagId in doc.tags" :key="tagId" class="mr-2">
                        {{ interventionContentTagById(tagId).name }}
                      </v-chip>
                    </v-expansion-panel-content>
                  </v-expansion-panel>
                </v-expansion-panels>
                <p v-else-if="read">{{ $t('interventions.interventionModal.noDocuments') }}</p>

                <v-card-title>
                  {{ $t('baseData.images') }}
                  <v-btn
                    v-if="!read"
                    fab
                    x-small
                    color="primary lighten-2"
                    class="ml-2"
                    @click="showToBeImplementedFeedback"
                  >
                    <v-icon dark> mdi-plus </v-icon>
                  </v-btn>
                </v-card-title>
                <div v-if="interventionInFocus && allImagesOfIntervention.length > 0">
                  <v-row>
                    <v-col
                      v-for="img in allImagesOfIntervention"
                      :key="img.id"
                      class="d-flex child-flex"
                      cols="3"
                    >
                      <v-img
                        src="https://picsum.photos/id/11/500/300"
                        lazy-src="https://picsum.photos/id/11/10/6"
                        aspect-ratio="1"
                      >
                        <template v-slot:placeholder>
                          <v-row class="fill-height ma-0" align="center" justify="center">
                            <v-progress-circular
                              indeterminate
                              color="grey lighten-5"
                            ></v-progress-circular>
                          </v-row>
                        </template>
                      </v-img>
                    </v-col>
                  </v-row>
                </div>
                <p v-else-if="read">{{ $t('interventions.interventionModal.noImages') }}</p>

                <v-card-title>
                  {{ $t('baseData.videos') }}
                  <v-btn
                    v-if="!read"
                    fab
                    x-small
                    color="primary lighten-2"
                    class="ml-2"
                    @click="showToBeImplementedFeedback"
                  >
                    <v-icon dark> mdi-plus </v-icon>
                  </v-btn>
                </v-card-title>
                <div v-if="interventionInFocus && allVideosOfIntervention.length > 0">
                  <div v-for="vid in allVideosOfIntervention" :key="vid.id">
                    <video width="50"></video>
                  </div>
                </div>
                <p v-else-if="read">{{ $t('interventions.interventionModal.noVideos') }}</p>

                <v-card-title>
                  {{ $t('baseData.surveys') }}
                  <v-btn
                    v-if="!read"
                    fab
                    x-small
                    color="primary lighten-2"
                    class="ml-2"
                    @click="showToBeImplementedFeedback"
                  >
                    <v-icon dark> mdi-plus </v-icon>
                  </v-btn>
                </v-card-title>
                <p v-if="read">
                  {{ $t('interventions.interventionModal.noSurveys') }}
                </p>
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
            {{ read ? 'Close' : $t('general.cancel') }}
          </v-btn>
          <v-btn x-large v-if="read" color="primary" text @click="editHandler"> Edit </v-btn>
          <v-btn
            x-large
            v-if="!read"
            type="submit"
            color="primary"
            text
            @click.prevent="submitHandler"
            :disabled="!interventionFormIsInvalid"
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
import { modalModesDict, dataTypesDict } from '../../store/constants';
import LocaleTextBox from '../global/LocaleTextBox.vue';
import { I18nString, Intervention, InterventionType } from '../../models';

const interventionDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_INTERVENTION_DESCRIPTION_MAX_CHAR, 10),
  0,
);

export default {
  name: 'InterventionModal',
  components: { LocaleTextBox },
  data() {
    return {
      interventionDescriptionMaxChar,
      InterventionType,
      rules: {
        maxChar: (value) => value.length <= interventionDescriptionMaxChar || this.maxCharExceededi18n,
      },
      id: null,
      name: new I18nString({
        languageKeys: this.$i18n.availableLocales,
        languageTexts: Array(this.$i18n.availableLocales.length).fill(''),
      }),
      type: InterventionType.TECHNOLOGY,
      description: new I18nString({
        languageKeys: this.$i18n.availableLocales,
        languageTexts: Array(this.$i18n.availableLocales.length).fill(''),
      }),
      tagIds: [],
      levelIds: [],
      contents: [],
    };
  },
  watch: { interventionDraft: 'prefillComponentDataFromInterventionDraft' },
  mounted() {
    this.prefillComponentDataFromInterventionDraft();
  },
  computed: {
    ...mapGetters({
      dataModalMode: 'dataModal/getMode',
      isDataModalDisplayed: 'dataModal/getIsDisplayed',
      dataType: 'dataModal/getDataType',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      interventionDraft: 'dataModal/getDataDraft',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
      LEVELById: 'LEVEL_Data/LEVELById',

      allInterventionTags: 'INTERVENTION_Data/getInterventionTags',
      tagById: 'INTERVENTION_Data/tagById',
      interventionContentTagById: 'INTERVENTION_Data/interventionContentTagById',

      calculateUILocaleString: 'calculateUILocaleString',
    }),
    isInterventionModalDisplayed() {
      return this.isDataModalDisplayed && this.dataType === dataTypesDict.intervention;
    },
    maxCharExceededi18n() {
      return this.$t('general.form.maxCharExceeded', {
        maxChar: interventionDescriptionMaxChar,
      });
    },
    interventionInFocus() {
      console.log('in focus', this.INTERVENTIONById({ id: this.dataIdInFocus }));
      console.log('id in focus', this.dataIdInFocus);
      return this.INTERVENTIONById({ id: this.dataIdInFocus });
    },
    interventionFormIsInvalid() {
      return !!this.name;
    },
    allDocumentsOfIntervention() {
      // const res = this.interventionInFocus.contents.filter((c) => c.type === 'MarkdownDocument') || [];
      // return res;
      return [];
    },
    allVideosOfIntervention() {
      // return this.interventionInFocus.contents.filter((c) => c.type === 'Video') || [];
      return [];
    },
    allImagesOfIntervention() {
      // return this.interventionInFocus.contents.filter((c) => c.type === 'Image') || [];
      return [];
    },
    edit() {
      return this.dataModalMode === modalModesDict.edit;
    },
    create() {
      return this.dataModalMode === modalModesDict.create;
    },
    read() {
      return this.dataModalMode === modalModesDict.read;
    },
  },
  methods: {
    ...mapActions({
      saveInterventionHandler: 'dataModal/saveData',
      deleteInterventionHandler: 'dataModal/deleteData',
      abortReadInterventionHandler: 'dataModal/abortReadData',
      abortNewInterventionHandler: 'dataModal/abortCreateData',
      abortEditInterventionHandler: 'dataModal/abortEditData',
      editInterventionHandler: 'dataModal/editData',
      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
    }),
    ...mapMutations({
      setINTERVENTIONDraft: 'dataModal/setINTERVENTIONDraft',
    }),
    deleteHandler() {
      if (this.read) return;
      this.deleteInterventionHandler({ dataType: dataTypesDict.intervention });
    },
    nameUpdatedHandler(res) {
      this.name = res;
    },
    descriptionUpdatedHandler(res) {
      this.description = res;
    },
    closeHandler() {
      if (this.read) this.abortReadInterventionHandler();
      else if (this.create) this.abortNewInterventionHandler({ dataType: dataTypesDict.intervention });
      else if (this.edit) {
        this.abortEditInterventionHandler({
          dataId: this.dataIdInFocus,
          dataType: dataTypesDict.intervention,
        });
      }
    },
    editHandler() {
      this.editInterventionHandler({
        dataId: this.dataIdInFocus,
        dataType: dataTypesDict.intervention,
      });
    },
    escHandler() {
      this.closeInterventionModal();
    },
    async submitHandler() {
      this.setINTERVENTIONDraft(
        new Intervention({
          name: this.name,
          description: this.description,
          interventionType: this.type,
          tags: this.tagIds,
          surveys: [], // TODO
          levels: [], // TODO
          contents: this.contents,
        }),
      );
      await this.$nextTick();
      this.saveInterventionHandler({ dataType: dataTypesDict.intervention });
    },
    selectImg() {
      this.showToBeImplementedFeedback();
      const imgInput = this.$refs['img-upload'];
      imgInput.click();
      // console.log('TODO: do something with', imgInput);
    },
    prefillComponentDataFromInterventionDraft() {
      this.name = this.interventionDraft?.name ?? '';
      this.description = this.interventionDraft?.description ?? '';
      this.tagIds = this.interventionDraft?.tagIds ?? [];
      this.contents = this.interventionDraft?.contents ?? [];
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
