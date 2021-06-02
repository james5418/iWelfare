<template>
  <div>
    <b-container fluid>
      <b-card bg-variant="secondary" text-variant="white" title="福利別">
        <b-button-group size="lg">
          <b-button
            v-for="(btn, idx) in button1"
            :key="idx"
            :pressed.sync="btn.state"
            variant="info"
          >
            {{ btn.caption }}
          </b-button>
        </b-button-group>
      </b-card>

      <b-card bg-variant="dark" text-variant="white" title="身份別">
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
      </b-card>

      <b-card bg-variant="secondary" text-variant="white">
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
      </b-card>

      <b-card bg-variant="dark" text-variant="white" title="設籍">
        <b-form-select
          v-model="selectArea"
          :options="area"
          class="mt-3"
          style="width: 50%"
        ></b-form-select>
        <br />
      </b-card>

      <br />
      <div>
        <b-button @click="search_welfare()">搜尋</b-button>
      </div>

      <div>
        <b-collapse id="collapse-t" v-model="table_visible" class="mt-2">
          <div style="right: 5rem">一共 {{ search_cnt }} 筆搜尋結果</div>
          <hr />
          <ReturnList :msgs="msgs" />
        </b-collapse>
      </div>
    </b-container>
  </div>
</template>

<script>
import ReturnList from "@/components/ReturnList.vue";

export default {
  components: { ReturnList },
  data() {
    return {
      button1: [
        { caption: "中低收入戶", tid: 21, state: false },
        { caption: "特殊境域家庭", tid: 15, state: false },
        { caption: "單親家庭", tid: 19, state: false },
        { caption: "交通", tid: 51, state: false },
      ],
      button2: [
        { caption: "身心障礙者", tid: 10, state: false },
        { caption: "原住民", tid: 30, state: false },
        { caption: "孕婦", tid: 35, state: false },
        { caption: "重大傷病", tid: 9, state: false },
      ],

      selectArea: null,
      area: [
        { text: "請選擇你的戶籍地", value: null, disabled: true },
        { text: "新北市", value: 52 },
        { text: "桃園市", value: 3 },
        { text: "台中市", value: 4 },
        { text: "台南市", value: 2 },
        { text: "屏東縣", value: 1 },
        { text: "其他", value: null },
      ],
      ageValue: 0,
      msgs: [],
      search_cnt: 0,
      table_visible: false,
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
    async search_tags(wid) {
      const qstr = `SELECT t.tag_id, tag FROM ( SELECT tag_id FROM corresponding WHERE welfare_id = ${wid} ) as c INNER JOIN tags t ON t.tag_id = c.tag_id ORDER BY c.tag_id`;
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });
      return val;
    },

    async search_welfare() {
      var tags = [];

      for (var j = 0; j < 4; j++) {
        if (this.button1[j]["state"]) {
          tags.push(this.button1[j]["tid"]);
        }
      }
      for (j = 0; j < 4; j++) {
        if (this.button2[j]["state"]) {
          tags.push(this.button2[j]["tid"]);
        }
      }
      if (this.selectArea != null) {
        tags.push(this.selectArea);
      }

      if (tags.length === 0) {
        alert("請選擇條件再進行搜尋！");
        return;
      }

      var qstr = `SELECT o.welfare_id , o.name FROM overall o, `;

      qstr += `(SELECT welfare_id FROM corresponding WHERE tag_id = "${
        tags[tags.length - 1]
      }" ) x, `;

      qstr += `(SELECT welfare_id FROM age WHERE (age_lower <= ${this.ageValue}) AND (age_upper >= ${this.ageValue}) ) y, `;

      qstr += `(SELECT welfare_id FROM corresponding WHERE `;

      for (var i = 0; i < tags.length - 1; ++i) {
        qstr += `(tag_id = "${tags[i]}") `;
        if (i != tags.length - 2) qstr += "OR ";
      }

      qstr += ` ) z WHERE o.welfare_id=x.welfare_id AND o.welfare_id=y.welfare_id AND o.welfare_id=z.welfare_id;`;

      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });

      this.search_cnt = val.length;
      this.table_visible = true;

      var arr = [];
      for (i = 0; i < val.length; ++i) {
        const got_tags = await this.search_tags(val[i]["welfare_id"]);

        arr.push({
          welfare_id: val[i]["welfare_id"],
          name: val[i]["name"],
          tags: got_tags,
        });
      }

      this.msgs = arr;
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss"></style>
