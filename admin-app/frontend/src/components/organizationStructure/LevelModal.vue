<template>
  <v-dialog
    v-model="levelModalIsDisplayed"
    max-width="800px"
    :persistent="persistModal"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        rounded
        x-large
        color="primary"
        @click="showlevelModal(true)"
        v-bind="attrs"
        v-on="on"
      >
        <v-icon class="mr-2"> mdi-plus </v-icon>
        {{ $t("organizationStructure.addNewLevel") }}
      </v-btn>
    </template>

    <v-card class="px-4 pt-4">
      <v-form ref="form" @submit.prevent="submitlevel" lazy-validation>
        <v-card-title>
          <h2 v-if="levelModalIsEdit">
            {{ $t("organizationStructure.levelModal.title.edit") }}
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
                  :items="levelStructure"
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
                    :items="technologies"
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
          <v-btn color="primary" text @click="showlevelModal(false)">
            {{ $t("general.cancel") }}
          </v-btn>
          <v-btn
            type="submit"
            color="primary"
            text
            @click.prevent="submitlevel()"
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
  name: "levelModal",
  data() {
    return {
      levelDescriptionMaxChar,
      levelModalIsDisplayed: false,
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
      levelStructure: "entities/getLevelStructure",
      technologies: "entities/getTechnologies",
      levelModalIsEdit: "entities/getLevelModalIsEdit",
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
    persistModal: function () {
      return Boolean(this.levelName || this.levelDescription);
    },
  },
  methods: {
    ...mapActions({
      savelevel: "entities/savelevel",
    }),
    showlevelModal: function (payload) {
      this.levelModalIsDisplayed = payload;
    },
    submitlevel: function () {
      this.showlevelModal(false);
      this.savelevel({
        levelName: this.levelName,
        levelDescription: this.levelDescription,
        technologies: this.levelAllowedTechnologies,
        upperLevel: this.levelIsSubordinateTo,
      });
    },
  },
};
</script>
