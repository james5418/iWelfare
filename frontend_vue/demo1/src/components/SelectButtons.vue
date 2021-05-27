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
    <!-- <p>
      Pressed States: <strong>{{ btnStates1 }}</strong>
    </p> -->

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
    <!-- <p>
      Pressed States: <strong>{{ btnStates2 }}</strong>
    </p> -->

    <h4>年齡:{{ ageValue }}</h4>
    <b-container class="bv-example-row">
      <b-row>
        <b-col cols="12">
          <VueSlider
            :min="0"
            :max="100"
            :marks="[0, 20, 40, 60, 80, 100]"
            drag-on-click
            :contained="true"
            v-model="ageValue"
            @change="$emit('input', ageValue)"
          />
        </b-col>
      </b-row>
    </b-container>

    <br />
    <br />
    <h4>設籍</h4>
    <b-form-select
      v-model="selected4"
      :options="area"
      class="mt-3"
      style="width: 50%"
    ></b-form-select>
    <!-- <div class="mt-3">
      Selected: <strong>{{ selected4 }}</strong>
    </div> -->

    <br />
    <br />
    <br />
    <div>
      <b-button @click="search_tag()">搜尋</b-button>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      button1: [
        { caption: "中低收入戶", state: false },
        { caption: "特殊境域家庭", state: false },
        { caption: "單親家庭", state: false },
        { caption: "交通", state: false },
      ],
      button2: [
        { caption: "身心障礙者", state: false },
        { caption: "原住民", state: false },
        { caption: "孕婦", state: false },
        { caption: "老人", state: false },
        { caption: "重大疾病", state: false },
      ],

      selected4: null,
      area: [
        { text: "請選擇你的戶籍地", value: null, disabled: true },
        { text: "新北市", value: "新北市" },
        { text: "桃園市", value: "桃園市" },
        { text: "台中市", value: "台中市" },
        { text: "台南市", value: "台南市" },
        { text: "屏東縣", value: "屏東縣" },
        { text: "其他", value: null },
      ],
      ageValue: 0,
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

  methods: {
    async search_tag() {
      var tags = [];

      for (var j = 0; j < 4; j++) {
        if (this.button1[j]["state"]) {
          tags.push(this.button1[j]["caption"]);
        }
      }
      for (j = 0; j < 5; j++) {
        if (this.button2[j]["state"]) {
          tags.push(this.button2[j]["caption"]);
        }
      }

      //age
      tags.push(this.ageValue);

      if (this.selected4 != null) {
        tags.push(this.selected4);
      }

      //console.log(this.input_tags);
      var qstr =
        "SELECT welfare_id FROM ( SELECT welfare_id, COUNT(*) as cnt FROM ( SELECT welfare_id, tag FROM corresponding as c JOIN tags as t ON c.tag_id = t.tag_id )as n WHERE ";
      //var qstr = "hello";
      for (var i = 0; i < tags.length; ++i) {
        qstr += "(n.tag = '" + tags[i] + "')";
        if (i != tags.length - 1) qstr += " OR ";
      }
      qstr += " GROUP BY welfare_id) as x WHERE cnt = " + tags.length;
      console.log(qstr);
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });

      console.log(val);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss"></style>
