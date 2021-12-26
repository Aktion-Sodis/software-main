<template>
  <v-dialog
    v-model="entityModalIsDisplayed"
    max-width="800px"
    :persistent="persistModal"
  >
    <v-card class="px-4 pt-4">
      <v-form ref="form" @submit.prevent="submitEntity" lazy-validation>
        <v-card-title>
          <h2 v-if="entityModalIsEdit">
            {{ $t("organizationStructure.entityModal.title.edit") }}
            <i>{{ entityCurrentlyBeingEdited.name }}</i>
          </h2>
          <h2 v-else>
            {{ $t("organizationStructure.entityModal.title.create") }}
          </h2>
        </v-card-title>
        <v-card-subtitle v-if="entityModalIsEdit">
          {{ $t("organizationStructure.entityModal.description.edit") }}
        </v-card-subtitle>
        <v-card-subtitle v-else>
          {{ $t("organizationStructure.entityModal.description.create") }}
        </v-card-subtitle>

        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6">
                <v-card-title> Entity information </v-card-title>
                <v-text-field
                  v-model="entityName"
                  :rules="[rules.required]"
                  :label="$t('organizationStructure.entityModal.entityName')"
                  required
                  outlined
                  dense
                  ref="entity-name"
                ></v-text-field>
                <v-textarea
                  v-model="entityDescription"
                  :counter="
                    entityDescription.length > entityDescriptionMaxChar - 20
                  "
                  :rules="[rules.maxChar]"
                  :label="
                    $t('organizationStructure.entityModal.entityDescription')
                  "
                  required
                  outlined
                  dense
                  ref="entity-description"
                ></v-textarea>

                <v-select
                  v-model="upperEntity"
                  :items="allEntitiesOfUpperLevel"
                  :label="$t('organizationStructure.entityModal.upperEntity')"
                  dense
                  outlined
                  persistent-hint
                  item-value="entityId"
                  item-text="name"
                  ref="upper-entity"
                ></v-select>
              </v-col>

              <v-col cols="12" sm="6">
                <v-card-title> Here be some other things </v-card-title>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="closeEntityModal">
            {{ $t("general.cancel") }}
          </v-btn>
          <v-btn
            type="submit"
            color="primary"
            text
            @click.prevent="submitEntity()"
            :disabled="!entityFormIsInvalid"
          >
            {{ $t("general.save") }}
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

const entityDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_ENTITY_DESCRIPTION_MAX_CHAR, 10),
  0
);

export default {
  name: "EntityModal",
  data() {
    return {
      entityDescriptionMaxChar,
      rules: {
        required: (value) => !!value || this.requiredi18n,
        maxChar: (value) =>
          value.length <= entityDescriptionMaxChar || this.maxCharExceededi18n,
      },
      entityName: "",
      entityDescription: "",
      upperEntity: null,
    };
  },
  computed: {
    ...mapGetters({
      allEntitiesOfLevel: "entities/getAllEntitiesOfLevelByHid",
      upperLevelById: "entities/getUpperLevelById",
      technologies: "entities/getTechnologies",
      entityModalIsEdit: "os/getEntityModalIsEdit",
      entityCurrentlyBeingEdited: "os/getEntityCurrentlyBeingEdited",
      entityModalIsDisplayed: "os/getEntityModalIsDisplayed",
      levelIdOfEntityBeingCreated: "os/getLevelIdOfEntityBeingCreated",
    }),
    allEntitiesOfUpperLevel() {
      const upperLevel = this.upperLevelById(this.levelIdOfEntityBeingCreated);
      return upperLevel ? this.allEntitiesOfLevel(upperLevel.levelId) : [];
    },
    requiredi18n() {
      return this.$t("login.required");
    },
    maxCharExceededi18n() {
      return this.$t("login.maxCharExceeded", {
        maxChar: entityDescriptionMaxChar,
      });
    },
    entityFormIsInvalid() {
      return !!this.entityName;
    },
    persistModal() {
      return Boolean(this.entityName || this.entityDescription);
    },
  },
  methods: {
    ...mapActions({
      saveEntity: "os/saveEntity",
      closeEntityModal: "os/closeEntityModal",
    }),
    prefillForm() {
      this.$refs["entity-name"].value =
        this.entityCurrentlyBeingEdited.name || "";
      this.$refs["entity-description"].value =
        this.entityCurrentlyBeingEdited.description || "";
    },
    submitEntity() {
      this.saveEntity({
        entityId: this.entityCurrentlyBeingEdited
          ? this.entityCurrentlyBeingEdited.entityId
          : null,
        entityName: this.entityName,
        entityDescription: this.entityDescription,
        entityLevelId: this.entityCurrentlyBeingEdited
          ? this.entityCurrentlyBeingEdited.levelId
          : this.levelIdOfEntityBeingCreated,
        entityUpperEntityId: this.upperEntity,
      });

      this.closeEntityModal();

      this.entityName = "";
      this.entityDescription = "";
      this.upperEntity = null;
    },
  },
};
</script>
