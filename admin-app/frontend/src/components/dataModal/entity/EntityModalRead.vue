<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2>
        {{ $t('organizationStructure.entityModal.modalTitle.read') }}
      </h2>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pb-0 px-0 mb-3 px-sm-3">
            <h2 v-if="entityInFocus">
              {{ calculateUILocaleString({ languageTexts: entityInFocus.name.languageTexts }) }}
            </h2>

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
          <v-col cols="12" sm="6" class="pt-0 px-0 px-sm-3">
            <ImgFromS3 :assumedSrc="deriveImgPath" dataType="entity" :key="rerenderImgFromS3">
              <template v-slot:v-img="slotProps">
                <v-img max-height="200px" :src="slotProps.src"> </v-img>
              </template>
            </ImgFromS3>
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

import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'EntityModalRead',
  components: { ImgFromS3 },
  data() {
    return {
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
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    entityInFocus() {
      return this.ENTITYById({ id: this.dataIdInFocus });
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
