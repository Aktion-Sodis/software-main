<template>
  <v-form lazy-validation>
    <v-card-title>
      <h2>
        {{ $t('interventions.modal.modalTitle.read') }}
      </h2>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12" sm="6" class="pb-0 px-0 px-sm-3">
            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('interventions.modal.name') }}
            </v-card-title>
            <h2 v-if="interventionInFocus">
              {{
                calculateUILocaleString({
                  languageTexts: interventionInFocus.name.languageTexts,
                })
              }}
            </h2>
            <v-card-title class="pt-4">
              {{ $t('interventions.modal.description') }}
            </v-card-title>
            <div
              v-if="interventionInFocus"
              class="d-flex flex-column justify-center"
              style="min-height: 10rem"
            >
              <h3>
                {{
                  calculateUILocaleString({
                    languageTexts: interventionInFocus.description.languageTexts,
                  })
                }}
              </h3>
            </div>
          </v-col>

          <v-col cols="12" sm="6" class="pt-6 pt-sm-3 px-0 px-sm-3">
            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('interventions.type.title') }}:

              <div v-if="interventionInFocus">
                <v-tooltip top>
                  <template v-slot:activator="{ on, attrs }">
                    <v-avatar v-bind="attrs" v-on="on">
                      <v-icon>
                        {{
                          interventionInFocus.interventionType === technology
                            ? 'mdi-hammer-wrench'
                            : 'mdi-school'
                        }}
                      </v-icon>
                    </v-avatar>
                  </template>
                  <span>{{
                    $t(`interventions.type.types.${interventionInFocus.interventionType}`)
                  }}</span>
                </v-tooltip>
              </div>
            </v-card-title>

            <v-card-title class="pt-0 pt-sm-2">
              {{ $t('interventions.modal.image') }}
            </v-card-title>

            <ImgFromS3 :assumedSrc="deriveImgPath" dataType="intervention">
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
import { InterventionType } from '../../../models';

import ImgFromS3 from '../../commons/ImgFromS3.vue';

export default {
  name: 'InterventionModalRead',
  components: { ImgFromS3 },
  // data() {
  //   return {
  //     rerenderImgFromS3: false,
  //   };
  // },
  computed: {
    ...mapGetters({
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    interventionInFocus() {
      return this.INTERVENTIONById({ id: this.dataIdInFocus });
    },
    deriveImgPath() {
      return deriveFilePath('interventionPicPath', { interventionID: this.dataIdInFocus });
    },
    technology() {
      return InterventionType.TECHNOLOGY;
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
