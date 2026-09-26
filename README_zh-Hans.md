# Big Shot Library（大人物库）由 vitellary 制作
用于 [Kristal](https://github.com/KristalTeam/Kristal) 的黄魂库, 还原了《Deltarune》中 Spamton NEO 战的射击模式。此仓库还包含一个示例模组，提供如何使用该库的示例代码。

## 如何使用（How to use）

### 灵魂（Soul）
要使 wave 或 encounter 使用黄色灵魂, 你需要按照 Kristal 维基上[制作波次的技巧与参考（Wavemaking Tricks and References）](https://kristal.cc/wiki/wavemaking-reference/#custom-souls)底部`自定义灵魂模式（Custom Soul Modes）`描述的流程，创建一个 `YellowSoul` 实例。YellowSoul 的构造函数接受参数 `x`、`y` 和 `angle`，其中 angle 定义灵魂在 wave 中面对的方向（默认为右）。

### 弹幕（Bullets）
要使弹幕对子弹产生反应，你可以为弹幕定义 `onYellowShot(shot, damage)`（见下文用法）, 或者继承该库提供的 [`YellowShotBullet` 对象](https://github.com/vitellaryjr/BigShotLibrary/blob/main/libraries/YellowSoul/scripts/objects/YellowSoulBullet.lua)。YellowShotBullet 对象可以使用，定义或覆盖以下函数：

`shot_health`：弹幕的“生命值”。普通子弹造成 1 点伤害，大型子弹造成 4 点伤害。默认值为 1，表示弹幕被击中 1 次即被摧毁。
`shot_tp`：弹幕被摧毁时玩家获得的 TP 值。默认值为 1%。

`onYellowShot(shot, damage)`：当弹幕被子弹命中（普通或大型）时调用。`shot` 是命中该弹幕的 [`YellowSoulShot`](https://github.com/vitellaryjr/BigShotLibrary/blob/main/libraries/YellowSoul/scripts/objects/YellowSoulShot.lua) 或 [`YellowSoulBigShot`](https://github.com/vitellaryjr/BigShotLibrary/blob/main/libraries/YellowSoul/scripts/objects/YellowSoulBigShot.lua) 实例， `damage` 是该次子弹造成的伤害。 该函数应返回 2 个值：第一个值定义普通子弹是否应在碰撞时销毁以及如何销毁；第二个值定义大型子弹的相同行为。若返回布尔值，则该值将决定弹幕是否应自行销毁；若回字符串，则会销毁弹幕，并播放由该字符串指定的图像路径的精灵动画（若字符串为 `a`、`b` 或 `c` ，则播放[库资源中](https://github.com/vitellaryjr/BigShotLibrary/tree/main/libraries/YellowSoul/assets/sprites/player/shot/hit)关联的动画。默认情况下，此函数按 `damage` 减少弹幕的 `shot_health`，并且若 `hot_health` 降为 0，则调用 `destroy()` 并返回 `"a", false`，这将销毁普通弹幕并播放动画，但不会销毁大型弹幕。
`destroy(shot)`：当弹幕的 `shot_health` 降为 0 时，由 `onYellowShot()` 调用。`shot` 是命中该弹幕的 `YellowSoulShot` 或 `YellowSoulBigShot` 实例。默认情况下，将 `shot_tp` 增加至玩家的 TP 中，并移除弹幕。

### 配置（Configuration）
该库包含可由用户定义的配置值，以控制模组中代码的某些方面。这些值包括：

`allowcheat`：是否允许玩家通过按住一个确认键并按下另一个确认键来快速连续发射大型子弹。默认值为 true。

## 黄魂（YellowSoul）
YellowSoul 对象有许多变量和函数，可用于修改或改变其行为。这些包括：

`can_use_bigshot`：是否允许灵魂发射大型子弹。默认值为 true。
`can_use_shots`：是否允许灵魂发射普通子弹。默认值为 true。
`can_shoot`：是否允许灵魂射击。默认值为 true。
`teaching`：若为 true，大型子弹的充能速度会变慢。默认值为 false。
`allow_cheat`：是否允许玩家通过按住一个确认键并按下另一个确认键来快速连续发射大型子弹。默认值取自配置值。

`getChargeSpeed()`：返回大型子弹的充能速度。默认情况下，若 `teaching` 为 true 则返回 1，否则返回 2。
`canUseBigShot()`, `canUseShots()`, `canShoot()`, `canCheat()`, `isTeaching()`：返回各自对应的值。
`fireShot(big)`：当玩家发射子弹时调用。`big` 是一个布尔值，定义是否为大型子弹。负责创建 YellowSoulShot 或 YellowSoulBigShot 对象。
`onCheat()`：每次玩家在不消耗充能的情况下发射大型子弹时调用。默认情况下，将 encounter 的 `funnycheat` 值增加 1，其它代码可以检查该值以在玩家作弊时执行相应操作（若需要）。请注意，`funnycheat` 在玩家作弊之前为 nil。
