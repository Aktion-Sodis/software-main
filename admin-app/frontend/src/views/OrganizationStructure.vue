<template>
  <div style="overflow-x: scroll; width: 100%">
    <h1 class="ml-8">Organization Structure</h1>
    <div class="my-8 d-flex">
      <div
        v-for="(hierarchy, index) in hierarchialStructure"
        :key="hierarchy.hierarchyId"
        class="column d-flex flex-column align-center px-8"
        :class="hierarchy.upperHierarchy === null || 'dotted-left-border'"
      >
        <h4 style="width: 100%">{{ hierarchy.name }}</h4>
        <div class="d-flex flex-column" style="width: 100%">
          <div
            v-for="entity in allEntitiesOfHierarchy(hierarchy.hierarchyId)"
            :key="entity.entityId"
            class="d-flex flex-column align-center my-8"
            style="position: relative"
          >
            <div>
              <div
                v-if="entityIsInTree(entity.entityId) && index !== 0"
                class="entity-connection-left-line"
              ></div>
              <div
                v-if="
                  getEntityShouldHaveVerticalLine(
                    entity.entityId,
                    entity.upperEntityId,
                    index
                  )
                "
                class="entity-connection-vertical-line"
              ></div>
            </div>
            <div
              v-if="
                hasChildren(entity.entityId) &&
                (entityIsInTree(entity.entityId) ||
                  entity.entityId === treeRoot.entityId)
              "
              class="entity-connection-right-line"
            ></div>
            <v-hover v-slot="{ hover }">
              <v-sheet
                class="mx-auto transition-swing grey lighten-5 rounded-lg pa-4 d-flex flex-column justify-center align-center"
                :class="hover ? 'lighten-2' : ''"
                elevation="4"
                style="
                  width: 100%;
                  height: 128px;
                  cursor: pointer;
                  position: relative !important;
                "
                @click="clickOnEntity(entity)"
              >
                {{ entity.name }}
                <br />
                vertical order
                {{
                  verticalOrderByEntityId(
                    entity.entityId,
                    hierarchy.hierarchyId
                  )
                }}
                <br />
                parent is above entity:
                {{
                  parentIsAboveEntity(
                    entity.entityId,
                    entity.upperEntityId,
                    entity.hierarchyId
                  )
                }}
                <v-btn fab icon class="entity-icon">
                  <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
                </v-btn>
              </v-sheet>
            </v-hover>
          </div>
          <AddEntityButton />
        </div>
      </div>
      <div
        class="column dotted-left-border d-flex flex-column align-center justify-center"
      >
        <v-dialog
          v-model="newLevelDialogIsDisplayed"
          max-width="800px"
          class="dialog"
          persistent
        >
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
                        :label="
                          $t('organizationStructure.newLevelDialog.levelName')
                        "
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
                          $t(
                            'organizationStructure.newLevelDialog.levelDescription'
                          )
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
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import AddEntityButton from "../components/organizationStructure/AddEntityButton.vue";

const levelDescriptionMaxChar = parseInt(
  process.env.VUE_APP_LEVEL_DESCRIPTION_MAX_CHAR,
  10
);

export default {
  name: "OrganizationStructure",
  components: { AddEntityButton },
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
  mounted() {},
  computed: {
    ...mapGetters({
      allEntitiesOfHierarchy: "entities/getAllEntitiesOfHierarchyByHid",
      hierarchialData: "entities/getHierarchialData",
      hierarchialStructure: "entities/getHierarchialStructure",
      hasSiblingsUnderIt: "entities/getEntityHasSiblingUnderIt",
      allDescendantsOfTreeRoot: "entities/getAllDescendantsOfTreeRoot",
      entityIsInTree: "entities/getEntityIsInTree",
      hasChildren: "entities/getHasChildren",
      treeRoot: "entities/getTreeRoot",
      verticalOrderByEntityId: "entities/getVerticalOrderByEntityId",
      getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy:
        "entities/getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy",
      parentInTreeRoot: "entities/getParentInTreeRoot",
      parentIsAboveEntity: "entities/getParentIsAboveEntity",
      getMinVerticalOrderOfTreeRootDescendantsInAHierarchy:
        "entities/getMinVerticalOrderOfTreeRootDescendantsInAHierarchy",
      getEntityShouldHaveVerticalLine:
        "entities/getEntityShouldHaveVerticalLine",
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
      return !!(this.levelName && this.levelDescription);
    },
  },
  methods: {
    ...mapActions({
      clickOnEntity: "entities/clickOnEntity",
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

<style scoped>
.column {
  min-width: 32rem;
}

.dotted-left-border {
  border-left: 4px rgb(0, 0, 0, 0.2) dotted;
}

.entity-connection-left-line {
  position: absolute;
  height: 3px;
  background-color: orange;
  width: 16px;
  left: -16px;
  top: 64px;
}

.entity-connection-right-line {
  position: relative;
  height: 3px;
  background-color: orange;
  width: 52px;
  left: calc(16rem - 6px);
  top: 64px;
}

.entity-connection-vertical-line {
  position: absolute;
  height: 195px;
  background-color: orange;
  width: 3px;
  left: -16px;
  top: 64px;
}

.entity-icon {
  position: absolute;
  top: 0;
  right: 0;
}

.dialog {
  width: 75%;
}
</style>
