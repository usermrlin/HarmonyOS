import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct CalorieStats {
  intake: number = 192
  expend: number = 150
  recommend: number = CommonConstants.RECOMMEND_CALORIE

  remianCalorie() {
    return this.recommend - this.intake + this.expend
  }

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      // 饮食摄入
      this.StateBuilder('饮食摄入', this.intake)
      // 还可以吃,
      Stack() {
        //   进度条
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        })
          .width(120)
          .style({ strokeWidth: CommonConstants.DEFAULT_10 })
          .color($r('app.color.primary_color'))
        // 统计数据
        this.StateBuilder('还可以吃', this.remianCalorie(), `推荐${this.recommend}`)
      }

      // 运动消耗
      this.StateBuilder('运动消耗', this.expend)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StateBuilder(label: string, value: number, tips?: string) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Text(label)
        .fontColor($r('app.color.gray'))
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
      Text(value.toFixed(0))
        .fontSize(20)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
      if (tips) {
        Text(tips)
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
      }
    }
  }
}