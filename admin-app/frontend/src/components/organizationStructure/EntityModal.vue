<template>
  <v-dialog v-model="isEntityModalDisplayed" max-width="800px" persistent @keydown.esc="escHandler">
    <v-card class="px-0 pt-0 px-md-4 pt-md-4">
      <v-form lazy-validation>
        <v-card-title>
          <h2 v-if="edit && entityInFocus">
            {{ $t('organizationStructure.entityModal.modalTitle.edit') }}
            <i>{{ entityInFocus.name }}</i>
          </h2>
          <h2 v-else-if="create">
            {{ $t('organizationStructure.entityModal.modalTitle.create') }}
          </h2>
          <h2 v-else-if="read">
            {{ $t('organizationStructure.entityModal.modalTitle.read') }}
          </h2>
        </v-card-title>
        <v-card-subtitle v-if="edit">
          {{ $t('organizationStructure.entityModal.modalDescription.edit') }}
        </v-card-subtitle>
        <v-card-subtitle v-else-if="create">
          {{ $t('organizationStructure.entityModal.modalDescription.create') }}
        </v-card-subtitle>

        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6" class="pb-0 px-0 px-sm-3">
                <h2 v-if="read && entityInFocus">
                  {{ entityInFocus.name }}
                </h2>
                <v-text-field
                  v-else
                  autofocus
                  v-model="name"
                  :label="$t('organizationStructure.entityModal.name')"
                  required
                  outlined
                  dense
                ></v-text-field>

                <div
                  v-if="read && entityInFocus"
                  class="d-flex flex-column justify-center"
                  style="min-height: 10rem"
                >
                  <h3>
                    {{ entityInFocus.description }}
                  </h3>
                </div>
                <v-textarea
                  v-else
                  v-model="description"
                  :counter="description.length > entityDescriptionMaxChar - 20"
                  :rules="[rules.maxChar]"
                  :label="$t('organizationStructure.entityModal.description')"
                  required
                  outlined
                  dense
                ></v-textarea>

                <div v-if="read && entityInFocus" style="min-height: 5rem">
                  <h3 v-if="entityInFocus.parentEntityID">
                    {{ $t('organizationStructure.entityModal.upperEntity') }}:
                    {{ ENTITYById({ id: entityInFocus.parentEntityID }).name }}
                  </h3>
                </div>
                <v-select
                  v-else-if="allEntitiesOfUpperLevel.length > 0"
                  v-model="parentEntityID"
                  :items="allEntitiesOfUpperLevel"
                  :label="$t('organizationStructure.entityModal.upperEntityLabel')"
                  dense
                  outlined
                  persistent-hint
                  item-value="id"
                  item-text="name"
                ></v-select>
              </v-col>
              <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
                <v-card-title class="pt-0 pt-sm-2"> More stuff coming soon. </v-card-title>
                <p>Adding Location, Custom Data and Tags will come in the next major update.</p>
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
import { modalModesDict, dataTypesDict } from '../../store/constants';

const entityDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_ENTITY_DESCRIPTION_MAX_CHAR, 10),
  0,
);

export default {
  name: 'EntityModal',
  data() {
    return {
      entityDescriptionMaxChar,
      rules: {
        maxChar: (value) => value.length <= entityDescriptionMaxChar || this.maxCharExceededi18n,
      },
      name: '',
      description: '',
      parentEntityID: null,
    };
  },
  watch: { entityDraft: 'prefillComponentDataFromEntityDraft' },
  mounted() {
    this.prefillComponentDataFromEntityDraft();
  },
  computed: {
    ...mapGetters({
      allEntitiesOfLevel: 'ENTITY_Data/allEntitiesByLevelId',
      upperLevelById: 'LEVEL_Data/upperLevelById',
      LEVELById: 'LEVEL_Data/LEVELById',

      dataType: 'dataModal/getDataType',
      modalMode: 'dataModal/getMode',
      isModalDisplayed: 'dataModal/getIsDisplayed',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      entityDraft: 'dataModal/getDataDraft',
      hasDescendants: 'ENTITY_Data/hasDescendantsById',

      ENTITYById: 'ENTITY_Data/ENTITYById',
      getCreatingEntityInLevelId: 'getCreatingEntityInLevelId',
    }),
    entityInFocus() {
      return this.dataIdInFocus ? this.ENTITYById({ id: this.dataIdInFocus }) : null;
    },
    isEntityModalDisplayed() {
      return this.isModalDisplayed && this.dataType === dataTypesDict.entity;
    },
    allEntitiesOfUpperLevel() {
      const currentLevel = this.LEVELById({
        id: this.edit ? this.entityInFocus?.entityLevelId : this.getCreatingEntityInLevelId,
      });
      return this.allEntitiesOfLevel({ entityLevelId: currentLevel?.parentLevelID }) ?? [];
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
    maxCharExceededi18n() {
      return this.$t('general.form.maxCharExceeded', {
        maxChar: entityDescriptionMaxChar,
      });
    },
    isFormInvalid() {
      return !this.name;
    },
    areThereChanges() {
      return (
        this.name !== this.entityDraft.name
        || this.description !== this.entityDraft.description
        || this.parentEntityID !== this.entityDraft.parentEntityID
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
      setEntityDraft: 'dataModal/setENTITYDraft',
    }),
    escHandler() {
      this.closeHandler();
    },
    deleteHandler() {
      if (this.read) return;
      if (this.hasDescendants({ id: this.dataIdInFocus })) {
        this.showFeedbackForDuration({
          type: 'warning',
          text: 'Cannot delete an entity with descendants.',
        });
        return;
      }
      this.deleteData({ dataType: dataTypesDict.entity });
    },
    closeHandler() {
      if (this.read) this.abortReadData();
      else if (this.create) this.abortCreateData({ dataType: dataTypesDict.entity });
      else if (this.edit) this.abortEditData({ dataId: this.dataIdInFocus, dataType: dataTypesDict.entity });
    },
    editHandler() {
      this.editData({ dataId: this.dataIdInFocus, dataType: dataTypesDict.entity });
    },
    async submitHandler() {
      this.setEntityDraft({
        id: this.dataIdInFocus,
        name: this.name,
        description: this.description,
        entityLevelId: this.edit
          ? this.entityInFocus.entityLevelId
          : this.getCreatingEntityInLevelId,
        parentEntityID: this.parentEntityID ?? null,
        _version: this.entityDraft._version,
      });
      await this.$nextTick();
      this.saveData({ dataType: dataTypesDict.entity });
    },
    prefillComponentDataFromEntityDraft() {
      this.name = this.entityDraft?.name ?? '';
      this.description = this.entityDraft?.description ?? '';
      this.parentEntityID = this.entityDraft?.parentEntityID ?? null;
      this.contents = this.entityDraft?.contents ?? [];
    },
  },
};
</script>
