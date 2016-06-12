#okuda https://oku.edu.mie-u.ac.jp/~okumura/stat/Rprofile.html

# install.packages()のレポジトリ
options(repos="https://cloud.r-project.org/")

if (capabilities("aqua")) {
    options(device="quartz")
}
setHook(packageEvent("grDevices", "onLoad"),
        function(...) {
            if (.Platform$OS.type == "windows")
                grDevices::windowsFonts(sans ="MS Gothic",
                                        serif="MS Mincho",
                                        mono ="FixedFont")
            if (capabilities("aqua"))
                grDevices::quartzFonts(sans=grDevices::quartzFont(
                                                                  c("Hiragino Kaku Gothic ProN W3",
                                                                    "Hiragino Kaku Gothic ProN W6",
                                                                    "Hiragino Kaku Gothic ProN W3",
                                                                    "Hiragino Kaku Gothic ProN W6")),
                                       serif=grDevices::quartzFont(
                                                                   c("Hiragino Mincho ProN W3",
                                                                     "Hiragino Mincho ProN W6",
                                                                     "Hiragino Mincho ProN W3",
                                                                     "Hiragino Mincho ProN W6")))
            # if (capabilities("X11"))
            #   grDevices::X11.options(
            #                          fonts=c("-kochi-gothic-%s-%s-*-*-%d-*-*-*-*-*-*-*",
            #                                  "-adobe-symbol-medium-r-*-*-%d-*-*-*-*-*-*-*"))
             grDevices::pdf.options(family="Japan1GothicBBB")
             grDevices::ps.options(family="Japan1GothicBBB")
             }
            )
attach(NULL, name = "JapanEnv")
assign("familyset_hook",
       function() {
           winfontdevs=c("windows","win.metafile",
                         "png","bmp","jpeg","tiff","RStudio")
           macfontdevs=c("quartz","quartz_off_screen","RStudio")
           devname=strsplit(names(dev.cur()),":")[[1L]][1]
           if ((.Platform$OS.type == "windows") &&
               (devname %in% winfontdevs))
               par(family="sans")
           if (capabilities("aqua") &&
               devname %in% macfontdevs)
               par(family="sans")
       },
       pos="JapanEnv")
setHook("plot.new", get("familyset_hook", pos="JapanEnv"))
setHook("persp", get("familyset_hook", pos="JapanEnv"))
# http://d.hatena.ne.jp/kiwamu_i/20100808/
setHook(packageEvent("lattice", "attach"),
        function(...) {
            lattice.options(default.args = list(as.table=TRUE))
            my.pdf.theme <- standard.theme("pdf", color=TRUE)
            my.pdf.theme$grid.pars <- list(fontfamily = "sans")
            my.pdf.theme$axis.text$fontfamily <- "sans"
            my.pdf.theme$axis.text$cex <- 1
            my.quartz.theme <- standard.theme("quartz", color=FALSE)
            my.quartz.theme$grid.pars <- list(fontfamily = "sans")
            my.quartz.theme$axis.text$fontfamily <- "sans"
            my.quartz.theme$axis.text$cex <- 1
            lattice.options(default.theme =
                            function() {
                                switch(EXPR = .Device,
                                       pdf = my.pdf.theme,
                                       my.quartz.theme)
                            })
        })
#vim-r-plugin http://www.lepem.ufc.br/jaa/r-plugin.html#r-plugin-use 
if(interactive()){
    # Get startup messages of three packages and set Vim as R pager:
    options(setwidth.verbose = 1,
            colorout.verbose = 1,
            vimcom.verbose = -1
    #        pager = "vimrpager")
            )
    # Use the text based web browser w3m to navigate through R docs:
    # if(Sys.getenv("TMUX") != "")
    #    options(browser="~/bin/vimrw3mbrowser",
    #            help_type = "html")
    # Use either Vim or GVim as text editor for R:
    if(nchar(Sys.getenv("DISPLAY")) > 1)
        options(editor = 'gvim -f -c "set ft=r"')
    else
        options(editor = 'vim -c "set ft=r"')
    # Load the colorout library:
    library(colorout)
    if(Sys.getenv("TERM") != "linux" && Sys.getenv("TERM") != ""){
        # Choose the colors for R output among 256 options.
        # You should run show256Colors() and help(setOutputColors256) to
        # know how to change the colors according to your taste:
        setOutputColors256(verbose = FALSE)
    }
    # Load the setwidth library:
    library(setwidth)
    # Load the vimcom .plus library only if R was started by Vim:
    if(Sys.getenv("VIMRPLUGIN_TMPDIR") != ""){
        #  library(vimcom .plus)
        # If you can't install the vimcom .plus package, do:
        library(vimcom)
        # See R documentation on Vim buffer even if asking for help in R Console:
        # if(Sys.getenv("VIM_PANE") != "")
        #     options(help_type = "text", pager = vim.pager)
    }
}
