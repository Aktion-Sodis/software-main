<template>
  <v-dialog
    v-model="levelModalIsDisplayed"
    max-width="800px"
    :persistent="persistModal"
  >
    <v-card class="px-4 pt-4">
      <v-form ref="form" @submit.prevent="submitLevel" lazy-validation>
        <v-card-title>
          <h2 v-if="levelModalIsEdit">
            {{ $t("organizationStructure.levelModal.title.edit") }}
            <i>{{ levelCurrentlyBeingEdited.name }}</i>
          </h2>
          <h2 v-else>
            {{ $t("organizationStructure.levelModal.title.create") }}
          </h2>
        </v-card-title>
        <v-card-subtitle v-if="levelModalIsEdit">
          {{ $t("organizationStructure.levelModal.description.edit") }}
        </v-card-subtitle>
        <v-card-subtitle v-else>
          {{ $t("organizationStructure.levelModal.description.create") }}
        </v-card-subtitle>

        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6">
                <v-card-title> Level information </v-card-title>
                <v-text-field
                  v-model="levelName"
                  :rules="[rules.required]"
                  :label="$t('organizationStructure.levelModal.levelName')"
                  required
                  outlined
                  dense
                ></v-text-field>
                <v-textarea
                  v-model="levelDescription"
                  :counter="
                    levelDescription.length > levelDescriptionMaxChar - 20
                  "
                  :rules="[rules.maxChar]"
                  :label="
                    $t('organizationStructure.levelModal.levelDescription')
                  "
                  required
                  outlined
                  dense
                ></v-textarea>

                <v-select
                  v-model="levelIsSubordinateTo"
                  :items="levels"
                  :label="
                    $t('organizationStructure.levelModal.levelIsSubordinateTo')
                  "
                  dense
                  outlined
                  persistent-hint
                  item-value="levelId"
                  item-text="name"
                ></v-select>
              </v-col>

              <v-col cols="12" sm="6">
                <v-card-title> Technologies </v-card-title>
                <v-card-text>
                  <v-select
                    v-model="levelAllowedTechnologies"
                    :items="allowedTechnologies"
                    :label="
                      $t(
                        'organizationStructure.levelModal.manageAllowedTechnologies'
                      )
                    "
                    multiple
                    dense
                    outlined
                    persistent-hint
                    item-value="technologyId"
                    item-text="name"
                  ></v-select>
                </v-card-text>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="closeLevelModal">
            {{ $t("general.cancel") }}
          </v-btn>
          <v-btn
            type="submit"
            color="primary"
            text
            @click.prevent="submitLevel()"
            :disabled="!levelFormIsInvalid"
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

const levelDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_LEVEL_DESCRIPTION_MAX_CHAR, 10),
  0
);

export default {
  name: "LevelModal",
  data() {
    return {
      levelDescriptionMaxChar,
      rules: {
        required: (value) => !!value || this.requiredi18n,
        maxChar: (value) =>
          value.length <= levelDescriptionMaxChar || this.maxCharExceededi18n,
      },
      levelName: "",
      levelDescription: "",
      levelAllowedTechnologies: [],
      levelIsSubordinateTo: null,
    };
  },
  computed: {
    ...mapGetters({
      levels: "entities/getSortedLevels",
      allowedTechnologies: "entities/getTechnologies",
      levelModalIsEdit: "os/getLevelModalIsEdit",
      levelModalIsDisplayed: "os/getLevelModalIsDisplayed",
      levelCurrentlyBeingEdited: "os/getLevelCurrentlyBeingEdited",
    }),
    requiredi18n() {
      return this.$t("login.required");
    },
    maxCharExceededi18n() {
      return this.$t("login.maxCharExceeded", {
        maxChar: levelDescriptionMaxChar,
      });
    },
    levelFormIsInvalid() {
      return !!this.levelName;
    },
    persistModal() {
      return Boolean(this.levelName || this.levelDescription);
    },
  },
  methods: {
    ...mapActions({
      saveLevel: "os/saveLevel",
      showLevelModal: "os/showLevelModal",
      closeLevelModal: "os/closeLevelModal",
    }),
    closeThenDeleteComponentData() {
      this.closeLevelModal();

      this.levelName = "";
      this.levelDescription = "";
      this.levelAllowedTechnologies = [];
      this.levelIsSubordinateTo = null;
    },
    submitLevel() {
      this.saveLevel({
        levelId: this.levelCurrentlyBeingEdited
          ? this.levelCurrentlyBeingEdited.levelId
          : null,
        name: this.levelName,
        description: this.levelDescription,
        allowedTechnologies: this.levelAllowedTechnologies || [],
        upperLevelId: this.levelIsSubordinateTo,
      });

      this.closeThenDeleteComponentData();
    },
  },
};
</script>
