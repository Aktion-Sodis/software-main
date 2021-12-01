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
                        <div
                            v-if="entityIsDescendantOfTreeRoot(entity.entityId)"
                            class="entity-connection-left-line"
                        >
                            <div
                                v-if="hasSiblingsUnderIt(entity.entityId, entity.hierarchyId)"
                                class="entity-connection-vertical-line"
                            ></div>
                        </div>
                        <div
                            v-if="hasChildren(entity.entityId) && (entityIsDescendantOfTreeRoot(entity.entityId) || entity.entityId === treeRoot.entityId)"
                            class="entity-connection-right-line"
                        ></div>
                        <v-hover v-slot="{ hover }">
                            <v-sheet
                                class="mx-auto transition-swing grey lighten-5 rounded-xl pa-4 text-center d-flex flex-column justify-center align-center"
                                :class="hover ? 'lighten-2' : ''"
                                elevation="4"
                                style="width: 100%; height: 128px; cursor: pointer"
                                @click="clickOnEntity(entity)"
                            >
                                <p>{{ entity.name }}</p>
                            </v-sheet>
                        </v-hover>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

export default {
    name: "OrganizationStructure",
    data: () => ({
    }),
    mounted() {
    },
    computed: {
        ...mapGetters({
            allEntitiesOfHierarchy: "entities/getAllEntitiesOfHierarchyByHid",
            hierarchialData: "entities/getHierarchialData",
            hierarchialStructure: "entities/getHierarchialStructure",
            hasSiblingsUnderIt: "entities/getEntityHasSiblingUnderIt",
            allDescendantsOfTreeRoot: "entities/getAllDescendantsOfTreeRoot",
            entityIsDescendantOfTreeRoot: "entities/getEntityIsDescendantOfTreeRoot",
            hasChildren: "entities/getHasChildren",
            treeRoot: "entities/getTreeRoot",
        }),
    },
    methods: {
        ...mapActions({
            clickOnEntity: 'entities/clickOnEntity', // map `this.add()` to `this.$store.dispatch('increment')`
        })
    }
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
    position: relative;
    height: 3px;
    background-color: orange;
    width: 16px;
    right: calc(16rem - 24px);
    top: 64px;
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
}
</style>
