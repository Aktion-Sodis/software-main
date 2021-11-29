<template>
    <div>
        <h1>Organization Structure</h1>
        <div style="min-width: 100%;" class="my-8 d-flex overflow-x-auto">
            <div
                v-for="(hierarchy, index) in hierarchialStructure"
                :key="hierarchy.hierarchyId"
                class="column d-flex flex-column align-center px-6"
                :class="hierarchy.upperHierarchy === null || 'dotted-left-border'"
            >
                <h4 style="width: 90%;">Level {{ index }}</h4>
                <div class="column-content-wrapper">
                    <v-hover
                        v-for="entity in allEntitiesOfHierarchy(hierarchy.hierarchyId)"
                        :key="entity.entityId"
                        v-slot="{ hover }"
                    >
                        <v-sheet
                            class="mx-auto transition-swing grey lighten-5 rounded-xl my-8 pa-4 text-center d-flex flex-column justify-center align-center"
                            :class="hover ? 'lighten-2' : ''"
                            elevation="4"
                            min-height="64"
                            width="100%"
                        >
                            <p>{{ entity.name }}</p>
                        </v-sheet>
                    </v-hover>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
    name: "OrganizationStructure",
    data: () => ({
    }),
    computed: {
        ...mapGetters({
            allEntitiesOfHierarchy: "entities/getAllEntitiesOfHierarchyByHid",
            hierarchialData: "entities/getHierarchialData",
            hierarchialStructure: "entities/getHierarchialStructure"
        }),
    }
};
</script>

<style scoped>
.column {
    min-width: 30rem;
    flex: auto;
}

.dotted-left-border {
    border-left: 4px rgb(0, 0, 0, 0.2) dotted;
}

.column-content-wrapper {
    display: flex;
    flex-direction: column;
    width: 90%;
}
</style>