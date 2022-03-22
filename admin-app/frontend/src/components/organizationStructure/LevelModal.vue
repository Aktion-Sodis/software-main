<template>
  <v-dialog v-model="isLevelModalDisplayed" max-width="800px" persistent @keydown.esc="escHandler">
    <v-card class="px-0 pt-0 px-md-4 pt-md-4">
      <v-form lazy-validation>
        <v-card-title>
          <h2 v-if="edit && levelInFocus">
            {{ $t('organizationStructure.levelModal.modalTitle.edit') }}
            <i>{{ levelInFocus.name.languageTexts[0] }}</i>
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
              <v-col cols="12" sm="6" class="pb-0 px-0 px-sm-3">
                <text-box></text-box>
                <h2 v-if="read && levelInFocus">
                  {{ levelInFocus.name.languageTexts[0] }}
                </h2>
                <v-text-field
                  v-else
                  autofocus
                  v-model="name"
                  :label="$t('organizationStructure.levelModal.name')"
                  required
                  outlined
                  dense
                ></v-text-field>

                <div
                  v-if="read && levelInFocus"
                  class="d-flex flex-column justify-center"
                  style="min-height: 10rem"
                >
                  <h3>
                    {{ levelInFocus.description.languageTexts[0] }}
                  </h3>
                </div>
                <v-textarea
                  v-else
                  v-model="description"
                  :counter="description.length > levelDescriptionMaxChar - 20"
                  :rules="[rules.maxChar]"
                  :label="$t('organizationStructure.levelModal.description')"
                  required
                  outlined
                  dense
                ></v-textarea>

                <div v-if="read && levelInFocus" style="min-height: 5rem">
                  <h3 v-if="levelInFocus.parentLevelID">
                    {{ $t('organizationStructure.levelModal.upperLevel') }}:
                    {{ LEVELById({ id: levelInFocus.parentLevelID }).name.languageTexts[0] }}
                  </h3>
                </div>
              </v-col>

              <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
                <LocaleTextBox :label="$t('organizationStructure.levelModal.name')" />
                <v-card-title class="pt-0 pt-sm-2">
                  {{ $t('organizationStructure.levelModal.interventions') }}
                </v-card-title>
                <div v-if="read && levelInFocus">
                  <div v-for="id in levelInFocus.allowedInterventions" :key="id">
                    <v-avatar>
                      <v-icon> mdi-hammer-wrench </v-icon>
                    </v-avatar>
                    <span v-if="INTERVENTIONById({ id })">
                      {{ INTERVENTIONById({ id }).name }}
                    </span>
                  </div>
                </div>
                <v-select
                  v-else
                  v-model="allowedInterventions"
                  :items="interventions"
                  :label="$t('organizationStructure.levelModal.manageAllowedInterventions')"
                  multiple
                  dense
                  outlined
                  persistent-hint
                  item-value="id"
                  item-text="name"
                ></v-select>

                <v-card-title>
                  {{ $t('baseData.tags') }}
                </v-card-title>
                <div v-if="read && levelInFocus">
                  <v-chip v-for="tagId in levelInFocus.tagIds" :key="tagId">
                    {{ tagById({ tagId }).name }}
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
                ></v-select>
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
          <v-btn x-large v-if="read" color="primary" text @click="editHandler"> {{ $t('general.edit') }} </v-btn>
          <v-btn
            x-large
            v-if="!read"
            type="submit"
            color="primary"
            text
            @click.prevent="submitHandler"
            :disabled="!isFormInvalid"
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
      rules: {
        maxChar: (value) => value.length <= levelDescriptionMaxChar || this.maxCharExceededi18n,
      },
      name: '',
      description: '',
      allowedInterventions: [],
      tagIds: [],
    };
  },
  watch: { levelDraft: 'prefillComponentDataFromLevelDraft' },
  computed: {
    ...mapGetters({
      interventions: 'INTERVENTION_Data/getInterventions',

      dataType: 'dataModal/getDataType',
      modalMode: 'dataModal/getMode',
      isModalDisplayed: 'dataModal/getIsDisplayed',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      levelDraft: 'dataModal/getDataDraft',

      allLevelTags: 'LEVEL_Data/getLevelTags',
      tagById: 'LEVEL_Data/tagById',
      lowestLevelId: 'LEVEL_Data/lowestLevelId',
      LEVELById: 'LEVEL_Data/LEVELById',

      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
    }),
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
      return !!this.name;
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
      const tagIdsInComponent = new Set(this.tagIds);
      const tagIdsInDraft = new Set(this.levelDraft.tagIds);

      const allowedInterventionsInComponent = new Set(this.allowedInterventions);
      const allowedInterventionsInDraft = new Set(this.levelDraft.allowedInterventions);
      return (
        this.name !== this.levelDraft.name
        || this.description !== this.levelDraft.description
        || !(
          tagIdsInComponent.size === tagIdsInDraft.size
          && [...tagIdsInComponent].every((value) => tagIdsInDraft.has(value))
        )
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
      setLevelDraft: 'dataModal/setLEVELDraft',
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
    submitHandler() {
      this.setLevelDraft({
        id: this.dataIdInFocus,
        name: this.name,
        description: this.description,
        parentLevelID: this.create ? this.lowestLevelId : this.levelInFocus.parentLevelID,
        allowedInterventions: this.allowedInterventions || [],
        tagIds: this.tagIds || [],
      });
      this.saveData({ dataType: 'LEVEL' });
    },
    prefillComponentDataFromLevelDraft() {
      this.name = this.levelDraft?.name ?? '';
      this.description = this.levelDraft?.description ?? '';
      this.tagIds = this.levelDraft?.tagIds ?? [];
      this.allowedInterventions = this.levelDraft?.allowedInterventions ?? [];
    },
  },
};
</script>
