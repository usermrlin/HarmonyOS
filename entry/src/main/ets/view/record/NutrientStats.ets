import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct NutrientStats {
  @Prop carbon: number
  @Prop protein: number
  fat: number = 7
  recommendCarbon: number = CommonConstants.RECOMMEND_CARBON
  recommendProtin: number = CommonConstants.RECOMMEND_PROTEIN
  recommendFat: number = CommonConstants.RECOMMEND_FAT

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      // 碳税化合物
      this.StateBuilder('碳税化合物', this.carbon, this.recommendCarbon, $r('app.color.carbon_color'))
      // 蛋白质
      this.StateBuilder('蛋白质', this.protein, this.recommendProtin, $r('app.color.protein_color'))
      // 脂肪
      this.StateBuilder('脂肪', this.fat, this.recommendFat, $r('app.color.fat_color'))
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StateBuilder(label: string, value: number, recommend: number, color: ResourceStr) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Stack() {
        //   进度条
        Progress({
          value: value,
          total: recommend,
          type: ProgressType.Ring
        })
          .width(95)
          .style({ strokeWidth: CommonConstants.DEFAULT_6 })
          .color(color)
        Column({ space: CommonConstants.SPACE_6 }) {
          Text('摄入推荐')
            .fontSize(12)
            .fontColor($r('app.color.light_gray'))
          Text(`${value.toFixed(0)}/${recommend.toFixed(0)}`)
            .fontSize(18)
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
        }
      }

      Text(`${label}(克)`)
        .fontSize(12)
        .fontColor($r('app.color.light_gray'))
    }
  }
}