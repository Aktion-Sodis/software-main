<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2 v-if="entityInFocus">
        {{
          $t('organizationStructure.entityModal.modalTitle.read', {
            entity: calculateUILocaleString({ languageTexts: entityInFocus.name.languageTexts }),
          })
        }}
      </h2>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pb-0 px-0 mb-3 px-sm-3">
            <div
              v-if="entityInFocus"
              class="d-flex flex-column justify-center"
              style="min-height: 10rem"
            >
              <h3>
                {{
                  calculateUILocaleString({
                    languageTexts: entityInFocus.description.languageTexts,
                  })
                }}
              </h3>
            </div>

            <div v-if="entityInFocus" style="min-height: 5rem">
              <h3 v-if="entityInFocus.parentEntityID">
                {{ $t('organizationStructure.entityModal.upperEntity') }}:

                {{
                  calculateUILocaleString({
                    languageTexts: ENTITYById({ id: entityInFocus.parentEntityID }).name
                      .languageTexts,
                  })
                }}
              </h3>
            </div>
          </v-col>
          <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3" v-if="entityInFocus">
            <ImgFromS3
              :assumedSrc="deriveImgPath"
              dataType="entity"
              :key="rerenderImgFromS3"
              class="mb-4"
            >
              <template v-slot:v-img="slotProps">
                <v-img max-height="200px" :src="slotProps.src"> </v-img>
              </template>
            </ImgFromS3>

            <div v-if="level.customData.length > 0">
              <v-divider></v-divider>
              <v-card-title class="pt-0 pt-sm-2">
                <span>
                  {{ $t('organizationStructure.levelModal.customData.title') }}
                </span>
              </v-card-title>

              <div
                class="mb-2"
                style="width: 100%"
                v-for="(customDatum, index) in level.customData"
                :key="customDatum.id"
              >
                <div
                  class="rounded-lg pa-4 d-flex justify-space-between align-center"
                  style="border: 1px solid; border-color: #736b5e; width: 100%"
                >
                  <h3 class="text-center">
                    {{
                      calculateUILocaleString({
                        languageTexts: customDatum.name.languageTexts,
                      })
                    }}
                  </h3>
                  <span v-if="entityInFocus.customData[index]">
                    <span
                      v-if="
                        entityInFocus.customData[index].stringValue ||
                        entityInFocus.customData[index].intValue
                      "
                    >
                      {{
                        entityInFocus.customData[index].type === Type.STRING
                          ? entityInFocus.customData[index].stringValue
                          : entityInFocus.customData[index].intValue
                      }}
                    </span>
                  </span>
                  <span v-else class="font-italic">
                    {{
                      customDatum.type === Type.STRING
                        ? $t('general.noTextProvided')
                        : $t('general.noNumberProvided')
                    }}
                  </span>
                </div>
              </div>
              <v-divider></v-divider>
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
import { Type } from '../../../models';

import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'EntityModalRead',
  components: { ImgFromS3 },
  data() {
    return {
      Type,
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
      ENTITYById: 'ENTITY_Data/ENTITYById',
      LEVELById: 'LEVEL_Data/LEVELById',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    entityInFocus() {
      return this.ENTITYById({ id: this.dataIdInFocus });
    },
    level() {
      return this.LEVELById({ id: this.entityInFocus.entityLevelId });
    },
    deriveImgPath() {
      return deriveFilePath('entityPicPath', { entityID: this.dataIdInFocus });
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
