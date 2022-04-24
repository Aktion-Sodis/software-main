<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2>
        {{ $t('organizationStructure.levelModal.modalTitle.read') }}
      </h2>
    </v-card-title>

    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('organizationStructure.levelModal.name') }}
            </v-card-title>
            <h2 v-if="levelInFocus">
              {{ calculateUILocaleString({ languageTexts: levelInFocus.name.languageTexts }) }}
            </h2>

            <v-card-title class="pt-4">
              {{ $t('organizationStructure.levelModal.description') }}
            </v-card-title>
            <div
              v-if="levelInFocus"
              class="d-flex flex-column justify-center"
              style="min-height: 10rem"
            >
              <h3>
                {{
                  calculateUILocaleString({
                    languageTexts: levelInFocus.description.languageTexts,
                  })
                }}
              </h3>
            </div>

            <div v-if="levelInFocus" style="min-height: 5rem">
              <h3 v-if="levelInFocus.parentLevelID">
                {{ $t('organizationStructure.levelModal.upperLevel') }}:
                {{
                  calculateUILocaleString({
                    languageTexts: LEVELById({ id: levelInFocus.parentLevelID }).name.languageTexts,
                  })
                }}
              </h3>
              <h3 v-else>-</h3>
            </div>
          </v-col>

          <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
            <ImgFromS3 :assumedSrc="deriveImgPath" dataType="level" :key="rerenderImgFromS3">
              <template v-slot:v-img="slotProps">
                <v-img max-height="200px" :src="slotProps.src"> </v-img>
              </template>
            </ImgFromS3>

            <v-card-title class="pt-0 pt-sm-2">
              <span>
                {{ $t('organizationStructure.levelModal.interventions') }}
              </span>
            </v-card-title>
            <div v-if="dataIdInFocus">
              <div v-if="interventionsOfLevelById({ levelId: dataIdInFocus }).length > 0">
                <div
                  v-for="intervention in interventionsOfLevelById({ levelId: dataIdInFocus })"
                  :key="intervention.id"
                >
                  <v-avatar>
                    <v-icon>
                      {{
                        intervention.interventionType === InterventionType.TECHNOLOGY
                          ? 'mdi-hammer-wrench'
                          : 'mdi-school'
                      }}
                    </v-icon>
                  </v-avatar>
                  <span>
                    {{
                      calculateUILocaleString({
                        languageTexts: intervention.name.languageTexts,
                      })
                    }}
                  </span>
                </div>
              </div>
              <div v-else>{{ $t('organizationStructure.hasNoInterventions') }}</div>
            </div>

            <v-card-title class="pt-0 pt-sm-2">
              <span>
                {{ $t('organizationStructure.levelModal.customData.title') }}
              </span>
            </v-card-title>

            <div v-if="levelInFocus">
              <div v-if="levelInFocus.customData.length > 0">
                <div
                  v-for="customDatum in levelInFocus.customData"
                  :key="customDatum.id"
                  class="mb-2"
                >
                  <div
                    class="rounded-lg pa-4 d-flex justify-space-between"
                    style="border: 1px solid; border-color: #736b5e; position: relative"
                  >
                    <div class="d-flex flex-column justify-space-between">
                      <h2 class="text-center mb-2">
                        {{ $t('organizationStructure.levelModal.customData.name') }}
                      </h2>
                      <span>
                        {{
                          calculateUILocaleString({
                            languageTexts: customDatum.name.languageTexts,
                          })
                        }}
                      </span>
                    </div>
                    <div class="d-flex flex-column">
                      <h2 class="text-center mb-2">
                        {{ $t('organizationStructure.levelModal.customData.type') }}
                      </h2>
                      <span>
                        {{
                          $t(
                            `organizationStructure.levelModal.customData.types.${
                              customDataTypesDict[customDatum.type]
                            }`
                          )
                        }}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
              <div v-else>
                {{ $t('organizationStructure.hasNoCustomData') }}
              </div>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>

    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn x-large color="secondary" text @click="abortReadData">
        {{ $t('general.close') }}
      </v-btn>
      <v-btn x-large color="primary" text @click="editData">
        {{ $t('general.edit') }}
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import { deriveFilePath } from '../../../lib/utils';
import { Type, InterventionType } from '../../../models';

import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'LevelModalRead',
  components: { ImgFromS3 },
  data() {
    return {
      customDataTypesDict: Type,
      InterventionType,
      rerenderImgFromS3: false,
    };
  },
  watch: {
    deriveImgPath() {
      this.rerenderImgFromS3 = !this.rerenderImgFromS3;
    },
  },
  computed: {
    ...mapGetters({
      dataIdInFocus: 'dataModal/getDataIdInFocus',

      LEVELById: 'LEVEL_Data/LEVELById',
      interventionsOfLevelById: 'LEVEL_Data/interventionsOfLevelById',

      calculateUILocaleString: 'calculateUILocaleString',
    }),
    levelInFocus() {
      return this.LEVELById({ id: this.dataIdInFocus });
    },
    deriveImgPath() {
      return deriveFilePath('levelPicPath', { levelID: this.dataIdInFocus });
    },
  },
  methods: {
    ...mapActions({
      abortReadData: 'dataModal/abortReadData',
      editData: 'dataModal/editData',
    }),
  },
};
</script>
