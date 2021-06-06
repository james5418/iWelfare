<template>
  <div class="about">
    <img src="/logo.png" align="middle" />
    
    <b-container>
      <br />
      <br />
      <h1 class="page-title">About</h1>
      <blockquote>
        <p>
          有鑑於國內社會福利領域的需求量越來越高，面臨的問題也越趨複雜，政府雖然擁有大量社福資源，但相關的資料十分分散，且目前臺灣沒有統一的查詢平台，民眾難以找到符合自身條件的補助項目。因此我們提供這樣的服務，期望能讓台灣的福利補助體系更加完善。
        </p>
        <p>
          iWelfare使用資料庫結合標籤管理系統，串聯並整合各地方政府和相關部會的社會福利資料集，將散落各處的社福補助項目標籤化分類整理。並以靈活的查詢功能，提供使用者相關資訊檢索的一站式服務，能更快地找到符合需求的補助項目，掌握住自身的社會福利資源。
        </p>
        <p>
          此外，我們訂定了完善資料庫的計畫，透過民眾外包（Crowdsourcing）的力量，快速擴增資料庫的涵蓋範圍，並將彙整好的資料以開源的形式，回饋給政府或民間使用，增加社福資源的利用率。
        </p>
      </blockquote>

      <br />
      <br />
      <h1 class="page-title">Contributors</h1>

      <b-card-group deck>
        <b-card
          title="周禹彤"
          img-src="/doge1.jpg"
          img-alt="Image"
          img-top
          style="width: 18rem"
        >
          <template #footer>
            <small class="text-muted">交大資工112級</small>
          </template>
        </b-card>

        <b-card
          title="王朋睿"
          img-src="/doge2.jpg"
          img-alt="Image"
          img-top
          style="width: 18rem"
        >
          <template #footer>
            <small class="text-muted">交大資工112級</small>
          </template>
        </b-card>

        <b-card
          title="王培碩"
          img-src="/doge3.jpg"
          img-alt="Image"
          img-top
          style="width: 18rem"
        >
          <template #footer>
            <small class="text-muted">交大資工112級</small>
          </template>
        </b-card>

        <b-card
          title="黃玟綾"
          img-src="/doge4.jpg"
          img-alt="Image"
          img-top
          style="width: 18rem"
        >
          <template #footer>
            <small class="text-muted">交大資工112級</small>
          </template>
        </b-card>
      </b-card-group>
    </b-container>
    <br />
    <br />
  </div>
</template>

<style scoped lang="scss">
.page-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-top: 0;
  margin-bottom: 0.75em;
}

blockquote {
  font-size: 1.25em;
  margin: 1em 20px 1em 20px;
  padding-left: 3em;
  border-left: 3px solid rgb(55, 53, 47);
  text-align: left;
}
</style>
