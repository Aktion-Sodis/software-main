<template>
  <v-dialog v-model="newLevelDialogIsDisplayed" max-width="800px" persistent>
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        rounded
        x-large
        color="primary"
        @click="showNewLevelDialog(true)"
        v-bind="attrs"
        v-on="on"
      >
        <v-icon class="mr-2"> mdi-plus </v-icon>
        {{ $t("organizationStructure.addNewLevel") }}
      </v-btn>
    </template>

    <v-card class="px-4 pt-4">
      <v-form ref="form" @submit.prevent="submitNewLevel" lazy-validation>
        <v-card-title> <h2>Create new level</h2> </v-card-title>
        <v-card-subtitle>
          This is the description of this beautiful dialog.
        </v-card-subtitle>

        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6">
                <v-card-title> Level information </v-card-title>
                <v-text-field
                  v-model="levelName"
                  :rules="[rules.required]"
                  :label="$t('organizationStructure.newLevelDialog.levelName')"
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
                    $t('organizationStructure.newLevelDialog.levelDescription')
                  "
                  required
                  outlined
                  dense
                ></v-textarea>

                <v-select
                  v-model="levelIsSubordinateTo"
                  :items="hierarchialStructure"
                  :label="
                    $t(
                      'organizationStructure.newLevelDialog.levelIsSubordinateTo'
                    )
                  "
                  dense
                  outlined
                  persistent-hint
                  item-value="hierarchyId"
                  item-text="name"
                ></v-select>
              </v-col>

              <v-col cols="12" sm="6">
                <v-card-title> Technologies </v-card-title>
                <v-card-text>
                  <v-select
                    v-model="levelAllowedTechnologies"
                    :items="technologies"
                    :label="
                      $t(
                        'organizationStructure.newLevelDialog.manageAllowedTechnologies'
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
          <v-btn color="primary" text @click="showNewLevelDialog(false)">
            {{ $t("general.cancel") }}
          </v-btn>
          <v-btn
            type="submit"
            color="primary"
            text
            @click.prevent="submitNewLevel()"
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

const levelDescriptionMaxChar = parseInt(
  process.env.VUE_APP_LEVEL_DESCRIPTION_MAX_CHAR,
  10
);

export default {
  name: "NewLevelModal",
  data() {
    return {
      levelDescriptionMaxChar,
      newLevelDialogIsDisplayed: true,
      rules: {
        required: (value) => !!value || this.requiredi18n,
        maxChar: (value) =>
          value.length <= levelDescriptionMaxChar || this.maxCharExceededi18n,
      },
      levelName: "",
      levelDescription: "",
      levelAllowedTechnologies: [],
      levelIsSubordinateTo: 0,
    };
  },
  computed: {
    ...mapGetters({
      hierarchialStructure: "entities/getHierarchialStructure",
      technologies: "entities/getTechnologies",
    }),
    requiredi18n: function () {
      return this.$t("login.required");
    },
    maxCharExceededi18n: function () {
      return this.$t("login.maxCharExceeded", {
        maxChar: levelDescriptionMaxChar,
      });
    },
    levelFormIsInvalid: function () {
      return !!this.levelName;
    },
  },
  methods: {
    ...mapActions({
      saveNewLevel: "entities/saveNewLevel",
    }),
    showNewLevelDialog: function (payload) {
      this.newLevelDialogIsDisplayed = payload;
    },
    submitNewLevel: function () {
      this.showNewLevelDialog(false);
      this.saveNewLevel({
        levelName: this.levelName,
        levelDescription: this.levelDescription,
        technologies: this.levelAllowedTechnologies,
        upperHierarchy: this.levelIsSubordinateTo,
      });
    },
  },
};
</script>
