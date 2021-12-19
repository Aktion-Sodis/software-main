<template>
  <div>
    <h1>Organization Structure</h1>
    <div class="my-8 d-flex" style="overflow-x: scroll">
      <div
        v-for="(hierarchy, index) in hierarchialStructure"
        :key="hierarchy.hierarchyId"
        class="column d-flex flex-column align-center px-8"
        :class="hierarchy.upperHierarchy === null || 'dotted-left-border'"
      >
        <h4 style="width: 100%">Level {{ index }}</h4>
        <div class="d-flex flex-column" style="width: 100%">
          <div
            v-for="entity in allEntitiesOfHierarchy(hierarchy.hierarchyId)"
            :key="entity.entityId"
            class="d-flex flex-column align-center my-8"
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
          width="75%"
          class="dialog"
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

          <v-form ref="form" @submit.prevent="submitNewLevel" lazy-validation>
            <v-card class="px-4 pt-4">
              <v-card-title> Create new level </v-card-title>
              <v-card-subtitle>
                This is the description of this beautiful dialog.
              </v-card-subtitle>

              <v-text-field
                v-model="levelName"
                :rules="[rules.required]"
                :label="$t('organizationStructure.newLevelDialog.levelName')"
                required
                outlined
              ></v-text-field>
              <v-text-field
                v-model="levelDescription"
                :rules="[rules.required]"
                :label="
                  $t('organizationStructure.newLevelDialog.levelDescription')
                "
                required
                outlined
              ></v-text-field>

              <v-divider vertical></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" text @click="showNewLevelDialog(false)">
                  Cancel
                </v-btn>
                <v-btn
                  type="submit"
                  color="primary"
                  text
                  @click="showNewLevelDialog(false)"
                  :disabled="!levelFormIsInvalid"
                >
                  Save
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-form>
        </v-dialog>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import AddEntityButton from "../components/organizationStructure/AddEntityButton.vue";

export default {
  name: "OrganizationStructure",
  components: { AddEntityButton },
  data() {
    return {
      newLevelDialogIsDisplayed: true,
      rules: {
        required: (value) => !!value || this.requiredi18n,
      },
      levelName: "",
      levelDescription: "",
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
    }),
    requiredi18n: function () {
      return this.$t("login.required");
    },
    levelFormIsInvalid: function () {
      return !!(this.levelName && this.levelDescription);
    },
  },
  methods: {
    ...mapActions({
      clickOnEntity: "entities/clickOnEntity",
    }),
    showNewLevelDialog: function (payload) {
      this.newLevelDialogIsDisplayed = payload;
    },
  },
};
</script>

<style scoped>
.column {
  width: 32rem;
}

.dotted-left-border {
  border-left: 4px rgb(0, 0, 0, 0.2) dotted;
}

.entity-connection-left-line {
  position: absolute;
  height: 3px;
  background-color: orange;
  width: 16px;
  transform: translate(calc(-16rem + 16px), 64px);
}

.entity-connection-right-line {
  position: relative;
  height: 3px;
  background-color: orange;
  width: 50px;
  left: calc(16rem - 8px);
  top: 64px;
}

.entity-connection-vertical-line {
  position: absolute;
  height: 196px;
  background-color: orange;
  width: 3px;
  transform: translate(calc(-16rem + 16px), 64px);
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
