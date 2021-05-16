<template>
  <div>
    <h4>福利別</h4>
    <b-button-group size="lg">
      <b-button
        v-for="(btn, idx) in button1"
        :key="idx"
        :pressed.sync="btn.state"
        variant="success"
      >
        {{ btn.caption }}
      </b-button>
    </b-button-group>
    <p>
      Pressed States: <strong>{{ btnStates1 }}</strong>
    </p>

    <h4>身份別</h4>
    <b-button-group size="lg">
      <b-button
        v-for="(btn, idx) in button2"
        :key="idx"
        :pressed.sync="btn.state"
        variant="info"
      >
        {{ btn.caption }}
      </b-button>
    </b-button-group>
    <p>
      Pressed States: <strong>{{ btnStates2 }}</strong>
    </p>

    <!-- <h4>性別</h4>
    <b-form-group v-slot="{ ariaDescribedby }">
      <b-form-radio-group
        id="btn-radios-2"
        v-model="selected2"
        :options="gender"
        :aria-describedby="ariaDescribedby"
        button-variant="outline-primary"
        size="lg"
        name="radio-btn-outline"
        buttons
      ></b-form-radio-group>
    </b-form-group> -->

    <!-- <h4>居住國內滿183天</h4>
    <b-form-group v-slot="{ ariaDescribedby }">
      <b-form-radio-group
        id="btn-radios-3"
        v-model="selected3"
        :options="live"
        :aria-describedby="ariaDescribedby"
        button-variant="outline-warning"
        size="lg"
        name="radio-btn-outline"
        buttons
      ></b-form-radio-group>
    </b-form-group> -->

    <h4>年齡:{{ ageValue }}</h4>
    <b-container class="bv-example-row">
      <b-row>
        <!-- <b-col cols="1">{{ ageValue }}</b-col> -->
        <b-col cols="12">
          <VueSlider
            min="0"
            max="100"
            :marks="[0, 20, 40, 60, 80, 100]"
            drag-on-click
            :contained="true"
            v-model="ageValue"
            @change="$emit('input', ageValue)"
          />
        </b-col>
      </b-row>
    </b-container>

    <br><br>
    <h4>年所得(萬元):{{ moneyValue }}</h4>
    <b-container class="bv-example-row">
      <b-row>
        <!-- <b-col cols="1">{{ moneyValue }}</b-col> -->
        <b-col cols="12">
          <VueSlider
            min="0"
            max="200"
            :marks="[0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200]"
            drag-on-click
            :contained="true"
            v-model="moneyValue"
            @change="$emit('input', moneyValue)"
          />
        </b-col>
      </b-row>
    </b-container>


    <br><br>
    <h4>設籍</h4>
    <b-form-select
      v-model="selected4"
      :options="area"
      class="mt-3"
      style="width: 50%"
    ></b-form-select>
    <div class="mt-3">
      Selected: <strong>{{ selected4 }}</strong>
    </div>
  </div>
</template>

<script>
// import AgeSlider from "@/components/AgeSlider.vue";

export default {
  components: {
    
  },
  data() {
    return {
      button1: [
        { caption: "中低收入戶", state: false },
        { caption: "特殊境域家庭", state: false },
        { caption: "老人", state: false },
      ],
      button2: [
        { caption: "身心障礙", state: false },
        { caption: "原住民", state: false },
        { caption: "孕婦或產婦", state: false },
        { caption: "單親家庭", state: false },
        { caption: "三個月內發生急難事故", state: false },
      ],
      gender: [
        { text: "男性", value: "male" },
        { text: "女性", value: "female" },
      ],
      live: [
        { text: "是", value: "true" },
        { text: "否", value: "false" },
      ],
      selected4: null,
      area: [
        { text: "請選擇你的戶籍地", value: null  },
        { text: "桃園市", value: "taoyuan" },
        { text: "台中市", value: "taizhong" },
        { text: "台南市", value: "tainan" },
        { text: "屏東市", value: "pingtung" },
      ],
    };
  },
  computed: {
    btnStates1() {
      return this.button1.map((btn) => btn.state);
    },
    btnStates2() {
      return this.button2.map((btn) => btn.state);
    },
  },
  props: {
    ageValue: Number,
    moneyValue: Number,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss"></style>
