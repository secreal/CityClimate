<template>
  <v-container class="py-10">
    <div class="mb-5">
      <h2>Xtramile City Climate</h2>
      <div v-if="selectedCity != ''">
        <p class="subtitle-1">Current situation in <u>{{ selectedCity.name }}</u></p>
      </div>
    </div>
    <v-row>
      <v-col md="4">
        <v-card elevation="2">
          <v-card-text>
            <v-combobox
                :items="listCountry"
                clearable
                filled
                hide-selected
                item-text="name"
                item-value="code"
                label="Select Country"
                outlined
                persistent-hint
                solo
                @change="countryChosen"
            ></v-combobox>
            <v-combobox
                v-model="selectedCity"
                :items="listCity"
                clearable
                filled
                hide-selected
                item-text="name"
                item-value="name"
                label="Select City"
                outlined
                persistent-hint
                solo
                @change="cityChosen"
            ></v-combobox>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col md="8">
        <v-card elevation="2">
          <v-card-text>
            <v-row>
              <v-col md="12">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0 text-center">
                    Location
                  </v-card-title>
                  <div v-if="climate != null && climate.location != null" class="pa-3">
                    <p class="ma-0">{{ climate.location }}</p>
                  </div>
                </v-card>
              </v-col>
            </v-row>
            <v-row>

              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Time
                  </v-card-title>
                  <div v-if="climate != null && climate.time != null" class="pa-3">
                    <p class="ma-0">{{ climate.time }}</p>
                  </div>
                </v-card>
              </v-col>

              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Wind
                  </v-card-title>
                  <div v-if="climate != null && climate.wind != null" class="pa-3">
                    <p class="ma-0">{{ climate.wind }}</p>
                  </div>
                </v-card>
              </v-col>
            <v-col md="4">
              <v-card class="box" outlined>
                <v-card-title class="pa-3 pb-0">
                  Visibility
                </v-card-title>
                <div v-if="climate != null && climate.visibility != null" class="pa-3">
                  <p class="ma-0">{{ climate.visibility }}</p>
                </div>
              </v-card>
            </v-col>
            </v-row>

            <v-row>


              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Sky Conditions
                  </v-card-title>
                  <div v-if="climate != null && climate.skyConditions != null" class="pa-3">
                    <p class="ma-0">{{ climate.skyConditions }}</p>
                  </div>
                </v-card>
              </v-col>

              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Temp (C)
                  </v-card-title>
                  <div v-if="climate != null && climate.temperatureCelcius != null" class="pa-3">
                    <p class="ma-0">{{ climate.temperatureCelcius }}</p>
                  </div>
                </v-card>
              </v-col>
              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Temp (F)
                  </v-card-title>
                  <div v-if="climate != null && climate.temperatureFahrenheit != null" class="pa-3">
                    <p class="ma-0">{{ climate.temperatureFahrenheit }}</p>
                  </div>
                </v-card>
              </v-col>
            </v-row>

            <v-row>


              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Dew Point
                  </v-card-title>
                  <div v-if="climate != null && climate.dewPoint != null" class="pa-3">
                    <p class="ma-0">{{ climate.dewPoint }}</p>
                  </div>
                </v-card>
              </v-col>

              <v-col md="4">
                <v-card class="box" outlined>
                  <v-card-title class="pa-3 pb-0">
                    Relative Humidity
                  </v-card-title>
                  <div v-if="climate != null && climate.relativeHumidity != null" class="pa-3">
                    <p class="ma-0">{{ climate.relativeHumidity }}</p>
                  </div>
                </v-card>
              </v-col>
            <v-col md="4">
              <v-card class="box" outlined>
                <v-card-title class="pa-3 pb-0">
                  Pressure
                </v-card-title>
                <div v-if="climate != null && climate.pressure != null" class="pa-3">
                  <p class="ma-0">{{ climate.pressure }}</p>
                </div>
              </v-card>
            </v-col>
            </v-row>

          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>

</template>

<script>
import {mapGetters} from "vuex";
import climateApi from "@src/api/climate-api";
import countryApi from "@src/api/country-api";
import moment from "moment";

export default {
  name: "Home",
  data() {
    return {
      selectedCity: "",
    };
  },
  methods: {
    async countryChosen(cityCode) {
      this.storageSave("listCity", await countryApi.getCity(cityCode.code));
      this.vuexFromStorage("listCity");
      console.log(this.listCity)
    },
    async cityChosen(city) {
      var climate = await climateApi.get(`${city.name},${city.countryCode}`);
      climate.time = moment(climate.time).format('DD MMMM YYYY, hh:mm A')
      climate.temperatureFahrenheit = climate.temperatureFahrenheit.toFixed(2)
      climate.temperatureCelcius = climate.temperatureCelcius.toFixed(2)
      this.storageSave("climate", climate);
      this.vuexFromStorage("climate");
    }
  },
  async mounted() {
    this.storageSave("listCountry", await countryApi.getAll());
    this.vuexFromStorage("listCountry");
    if (this.climate == null) {
      var emptyClimate = {
        dewPoint: "",
        location: "",
        pressure: "",
        relativeHumidity: "",
        skyConditions: "",
        temperatureCelcius: "",
        temperatureFahrenheit: "",
        time: "",
        visibility: "",
        wind: "",
      };
      this.storageSave("climate", emptyClimate);
      this.vuexFromStorage("climate");
    }
  },
  computed: {
    ...mapGetters({
      listCountry: 'base/listCountry',
      listCity: 'base/listCity',
      climate: 'base/climate',
    }),

  },
  components: {},

};
</script>
<style scoped>
.box {
  font-size: 1rem;
  background-color: rgba(168, 224, 255, 0.35) !important;
}
</style>
