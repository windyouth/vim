"-------基本设置-------“
set tabstop=4									"设置tab键长度
set cindent										"使用C/C++语言的自动缩进方式
set shiftwidth=4								"自动缩进使用4个空格
set number										"使用行号
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

"-------注册tags文件所在的目录-------"
set tags=tags
set tags+=/usr/include/tags
set tags+=/usr/local/include/tags
set tags+=/usr/src/kernels/tags

"-- Taglist setting --
let Tlist_Ctags_Cmd='ctags'						"因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 					"让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=1 						"让taglist可以不能同时展示多个文件的函数列表
let Tlist_File_Fold_Auto_Close=0 				"非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 					"当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 				"是否一直处理tags.1:处理;0:不处理
let Tlist_Inc_Winwidth=0						"这个值好像设了也没用
let Tlist_WinWidth = 25							"窗口宽度

 "-- Cscope setting --
if has("cscope")
	set csprg=/usr/bin/cscope        			" 指定用来执行cscope的命令
	set csto=1                        			" 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库
	set cst	                            		" 同时搜索cscope数据库和标签文件
	set cscopequickfix=s-,g-,c-,d-,i-,t-,e-		" 使用QuickFix窗口来显示cscope查找结果
	set nocsverb
	if filereadable("cscope.out")				" 若当前目录下存在cscope数据库，添加该数据库到vim
		cs add cscope.out
	elseif $CSCOPE_DB != ""        			    " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
		cs add $CSCOPE_DB
	endif
	set csverb
endif

"--------nerdtree设置--------"
let NERDTreeMinimalUI = 1												"不显示帮助面板
let NERDTreeDirArrows = 0 												"目录箭头：1-显示箭头 0-传统+-|号
let NERDTreeWinSize = 19 												"窗口宽度
let NERDTreeIgnore = ['\.out$', '\~$', 'tags', 'obj', 'hlnet']			"忽略以.out,~结尾的文件
"vim打开时不指定具体文件，自动使用nerdtree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"vim打开某一目录时，自动使用nerdtree
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"-----------------------------自定义快捷键------------------------”

"创建新窗口
map <F1> :split blank<CR><C-W>h
imap <F1> <ESC>:split blank<CR><C-W>h
"切换窗口
map <F2> <C-W>h
map <F3> <C-W>l
"保存
map <F4> :wall<CR>
imap <F4> <ESC>:wall<CR>
"根据本文件内自动补全
imap <F5> <C-X><C-N>
"根据包含头文件内关键字补全
imap <F6> <C-X><C-I>
"打开新标签
map <F8> :tabnew blank<CR>:NERDTreeToggle<CR><C-W>h
imap <F8> <ESC>:tabnew blank<CR>:NERDTreeToggle<CR><C-W>h
"打开quickfix窗口，quickfix窗口要先做一次cscope操作后才能打开。
map <F9> :cw<CR><C-W>k
imap <F9> <ESC>:cw<CR><C-W>ki
"打开/关闭标签窗口
map <F10> <C-W>k:TlistToggle<CR><C-W>l
imap <F10> <ESC><C-W>k:TlistToggle<CR><C-W>l
"按F5键重新生成tags文件
map <F11> :!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>
imap <F11> <ESC>:!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>i
"按F6键重新生成cscope数据库文件
map <F12> :!cscope -Rbq<CR><CR>
imap <F12> <ESC>:!cscope -Rbq<CR><CR>i
"上下切换窗口
map <TAB> <C-W>j
map ' <C-W>k
"cscope的快捷键，查找函数定义。
map ; :cs find s <C-R>=expand("<cword>")<CR><CR>
map . :cs find g <C-R>=expand("<cword>")<CR><CR>
map c :cs find c <C-R>=expand("<cword>")<CR><CR>
"翻页
map m <C-D> 
map , <C-U>
"在h和cpp文件中切换
map z :A<CR>
"查找字符串
map E :cs find e 
"在quickfix窗口中前进/后退
map n :cn<CR>
map f :cp<CR>
"文件内查找关键字
map t /<C-R>=expand("<cword>")<CR><CR>
map q ?<C-R>=expand("<cword>")<CR><CR>
"关闭标签
map ge :tabc<CR>
"追踪tags
map g; <C-]>
"打开/关闭nerdtree插件
nmap gm :NERDTreeToggle<CR><C-W>h
"退出程序
map gn :qall<CR>
"剪切或者复制一个单词
map gi viws
map go viwp
map gl yiw
map gh viwx
"左右切换标签，打开关闭标签。
map <C-L> :tabn<CR>
imap <C-L> <ESC>:tabn<CR>
map <C-H> :tabp<CR>
imap <C-H> <ESC>:tabp<CR>
