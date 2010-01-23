scriptencoding cp932
let g:QFixHowmMenuList = [ '-------------------------------------', 'メニューの書き方', '普通のhowmファイルなので適当に編集して下さい。', '', 'ここにキーワードや、マクロアクション、よく使うファイルなど、書いておくと便利です。', 'メニュー画面ファイルは何処にあってもリンク作成の対象になります。', 'Wikiスタイルリンクなどを定義しておくと便利かもしれません。', '', '-------------------------------------', 'よく使うリンクやファイル', 'http://sites.google.com/site/fudist/Home/qfixhowm', '', '[[Wikiスタイルリンク]]', '', '-------------------------------------', '解説目次', '', 'howm コマンド <|> $:/howm コマンド<CR>:noh<CR>zz', 'Quickfixウィンドウでの操作 <|> $:/Quickfixウィンドウでの操作<CR>:noh<CR>zz', 'アクションロック <|> $:/アクションロック<CR>:noh<CR>zz', '予定・TODO の書式 <|> $:/予定・TODOの書式<CR>:noh<CR>zz', '予定・TODOの繰り返し <|> $:/予定・TODOの繰り返し<CR>:noh<CR>zz', '', '', '-------------------------------------', ':howm コマンド', 'キーマップリーダーが g の場合、「新規ファイルを作成」は g,c です。', '', '  ,c       : 新規ファイルを作成', '  ,u       : クイックメモファイルを開く', '  ,<Space> : 日記を書く', '', '  ,l       : 最近更新したエントリの検索(デフォルトでは過去5日間)', '  ,L       : 最近"作成"したエントリの検索(デフォルト検索日数は,lと共用)', '  ,m       : howmファイル専用のMRUリスト表示', '  ,rm      : howmのMRUリストから存在しないエントリを削除', '', '  ,s       : エントリを正規表現を使わないで検索', '  ,g       : エントリをgrep', '  ,\g      : エントリをgrepの設定にかかわらずvimgrep使用でgrep', '  ,a       : 過去エントリを全て検索', '  ,A       : ファイルリストを表示', '', '  ,i       : サイドバーを開く', '  ,k       : 保存したgrep結果を読み込む', '  ,rr      : ランダム表示', '  ,rR      : ランダム表示用のエントリリストファイルをリビルド', '  ,rk      : オートリンクキーワードファイルをリビルド', '', 'バッファローカルなコマンド', '', '  ,w       : howmタイムスタンプを変更しないで保存', '', '  ,d       : 現在日付を挿入', '  ,T       : 現在時刻を挿入', '', '  ,C       : 現在行の後に新規エントリを追加', '  ,n       : 現エントリの次に新規エントリを追加', '  ,N       : 現バッファの最後に新規エントリを追加', '  ,p       : 現エントリの前に新規エントリを追加', '  ,P       : 現バッファの先頭に新規エントリを追加', '', '  ,o       : アウトラインモード', '  ,rd      : 予定・TODOの定義行で実行すると、指定カウント分の予定・TODOに展開', '', '  ,S       : 現在位置のエントリの更新時刻を更新(高速化オプション設定時のみ)', '  ,W       : 一ファイル複数メモや連結表示を分割して保存。', '             ファイルは howm_dir へ作成される。', '  ,x       : 現在位置のエントリを削除', '  ,X       : 現在位置のエントリを新規ファイルへ移動', '  ,rs      : 現バッファのエントリをhowmタイムスタンプの新しい順番でソート', '  ,rS      : 現バッファのエントリをhowmタイムスタンプの古い順番でソート', '', '予定・TODO (グローバル)', '', '  ,y       : 予定の表示', '  ,t       : TODOの表示', '', 'grepコマンド (グローバル)', '', '  ,b       : 現在開いている全てのバッファを対象にgrep', '  ,f       : 現編集バッファと同じディレクトリで固定文字列検索', '  ,e       : 現編集バッファと同じディレクトリでgrep', '  ,v       : 現編集バッファと同じディレクトリでvimgrep', '', '-------------------------------------', ':Quickfixウィンドウでの操作', '', '  <C-w>,   : Quickfixウィンドウのオープン/クローズ', '  <C-w>.   : Quickfixウィンドウへ移動', '   q       : Quickfixウィンドウのクローズ', '', '  <CR>     : ファイルを開く', '  <S-CR>   : 画面分割してファイルを開く', '', '   s       : 指定文字列を含む行を絞り込み検索', '   r       : 指定文字列を含まない行を絞り込み検索', '   S       : ソート切替。', '   u       : 絞り込み/ソートのアンドゥ', '   U       : 絞り込み/ソートを全て元に戻す', '', '   J       : ジャンプ後にQuickfixウィンドウを閉じる/閉じないをトグル', '   i       : プレビュー表示ON/OFF', '   I       : ファイルタイプのハイライト表示ON/OFF', '  <C-h>    : ハイスピードプレビュー ON/OFF', '  <C-l>    : パス表示が長い場合、短く表示する(直前に編集していたバッファのカレントディレクトリを基準)', '', '  <C-o>    : Quickfix画面を保存', '  <C-i>    : Quickfix画面を読み込む', '', '   #       : 検索結果のうち同一エントリのものを一つにまとめる。', '   @       : 表示中(選択中)のファイルを連結表示', '  <F5>     : ランダム表示', '', '   R       : (選択中の)ファイルを howm_dir へ移動', '   D       : (選択中の)ファイルを削除', '   x       : エントリを削除', '   X       : エントリを新規ファイルへ移動', '   !       : 対応プラグインが有る場合、予定・TODOをエクスポート', '', 'キーマップリーダーが g の場合', '  g.       : 予定・TODO表示で、現在日付の行へ移動', '', '-------------------------------------', ':アクションロック', '', '日付変更', '日付部分にカーソルを合わせて<CR>を押すと、日付を変更できます。', '', '1-31, .      : 指定の日付に変更(.なら今日)', '0-031,32-999 : 今日の日付に入力値を足した日付に変更', 'mmdd         : 変更したい月日を4桁の数値で入力', 'yymmdd       : 変更したい年月日を6桁の数値で入力', 'yyyymmdd     : 変更したい年月日を8桁の数値で入力', '', '{ } にカーソルを合わせて<CR>を押すと、以下の順にループして変化します。', '{ } → {*} → {-}', '', '{_} にカーソルを合わせて<CR>を押すと、現在時刻の対処済予定に変化します。', '{_} → [2009-01-01 01:01].', '', '-------------------------------------', ':予定・TODOの書式', '', '[2009-01-01]＠   予定', '[2009-01-01]＋7  TODO', '[2009-01-01]！7  締め切り', '[2009-01-01]−1  リマインダ', '[2009-01-01]〜30 浮沈TODO', '[2009-01-01]．   対処済', '(記号の後の数字はデフォルト値、省略可)', '(＠＋！−〜は実際は半角で)', '', '@ 予定', '日付がそのまま、優先度になります。', '', '! 締め切り (デフォルト値 7日)', '締め切り7日前(デフォルトの場合)から表示されるようになります。', '文字通り、締め切りや納期などに使用します。', '', '+ TODO (デフォルト値 7日)', '指定日から7日間(デフォルトの場合)ぐらいまでの間に実行したい事を登録します。', '', '- リマインダ (デフォルト値 1日)', '気になるけれど、買うかどうか決めていない本の発売日など、やらなくてもかまわないような覚え書きを登録します。', '指定日から1日(デフォルトの場合)の間は優先度0日に設定され、優先度が下がる事はありません。', '', '~ 浮沈TODO (デフォルト値 30 日)', '適当に優先度が変わるので、いつかやろうと思っている事などを登録します。', '', '. 対処済', '対処済みで不要になった予定やTODOに使用してください。', '', '-------------------------------------', ':予定・TODOの繰り返し', '予定・TODOの繰り返しには @!+-~ が使え、数値オプションも指定可能です。', '日付以外の予定・TODOの定義部分はアクションロックになっています。', '', '[2009-01-10]＠ 2009年1月10日は舞踏会の日', '[2009-01-10]＠＠ 2009年1月10日から、毎月10日は舞踏会の日', '[2009-01-10]＠＠＠ 2009年1月10日から、毎年1月10日は舞踏会の日', '[2009-01-10]＠(7) 2009年1月10日から、7日おきに(毎週土曜は)舞踏会の日', '', '予定・TODOは指定曜日で前後にずらせます。', '次のように+-と()の中の曜日指定子で、その日が指定曜日なら前後にずらします。', '', '[2009-01-10]＋＋＋(+Mon)', '[2009-01-10]＠(7-Sun)', '', '(1*Sat)のように * を使うと毎月/毎年の特定曜日の予定が使用できます。', '(3*Wed) なら第3水曜です。', '', '[2009-01-10]＋＋＋(1*Mon)', '[2009-01-10]＠＠(2*Sun)', '', 'また繰り返し予定行で 3g,rdのようにコマンドを実行すると、単発予定に展開できます。', '' ]
