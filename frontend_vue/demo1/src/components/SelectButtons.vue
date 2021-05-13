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
    <p>Pressed States: <strong>{{ btnStates1 }}</strong></p>


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
    <p>Pressed States: <strong>{{ btnStates2 }}</strong></p>


    <h4>性別</h4>
    <b-form-group
      v-slot="{ ariaDescribedby }"
    >
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
    </b-form-group>
    

    <h4>居住國內滿183天</h4>
    <b-form-group
      v-slot="{ ariaDescribedby }"
    >
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
    </b-form-group>

    <h4>出身年月（年齡）</h4>
    

    <h4>設籍</h4>

    
    
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      button1: [
        { caption: '中低收入戶', state: false },
        { caption: '特殊境域家庭', state: false },
        { caption: '老人', state: false },
      ],
      button2: [
        { caption: '身心障礙', state: false },
        { caption: '原住民', state: false },
        { caption: '孕婦或產婦', state: false },
        { caption: '單親家庭', state: false },
        { caption: '三個月內發生急難事故', state: false },
      ],
      gender: [
          { text: '男性', value: 'male' },
          { text: '女性', value: 'female' }
      ],
      live:[
        { text: '是', value: 'true' },
        { text: '否', value: 'false' }
      ]
    }
  },
  computed: {
    btnStates1() {
      return this.button1.map(btn => btn.state)
    },
    btnStates2() {
      return this.button2.map(btn => btn.state)
    },
    
    
  }
}
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">

</style>
