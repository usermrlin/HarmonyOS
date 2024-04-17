import SearchHeader from './SearchHeader'
import StatsCard from './StatsCard'

@Component
export default struct RecordIndex {
  build() {
    Column() {
      //   头部搜索栏
      SearchHeader()
      //   统计卡片
      StatsCard()
      //   记录列表
      Text('记录列表')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}