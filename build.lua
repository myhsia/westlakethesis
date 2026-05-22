--[==========================================[--
        L3BUILD FILE FOR WESTLAKETHESIS
      Once Pushed With This File Modified
        A New Release Will Be Published
--]==========================================]--

--[==========================================[--
               Basic Information
             Do Check Before Push
--]==========================================]--

module              = "westlakethesis"
version             = "v0.0.1"
date                = "2026-05-30"
maintainer          = "Mingyu Xia"
uploader            = "Mingyu Xia"
maintainid          = "myhsia"
email               = "xiamingyu@westlake.edu.cn"
repository          = "https://github.com/" .. maintainid .. "/" .. module
summary             = "LaTeX bundle for Westlake University dissertations."
description         = "The `WESTLAKEthesis` is a LaTeX bundle for Westlake University dissertations, including Ph.D. thesis and Beamer theme."

--[==========================================[--
          Build, Pack, Tag, and Upload
         Do not Modify Unless Necessary
--]==========================================]--
checkengines        = {"xetex", "uptex"}
ctanzip             = module
cleanfiles          = {"*.log", "*.pdf", "*.zip", "*.curlopt"}
excludefiles        = {"*~"}
installfiles        = {"*.sty", "*.cls", "*.code.tex", "*.pdf", "*.png"}
sourcefiles         = {"*.dtx", "*.ins", "./media/*.pdf", "./media/*.png"}
textfiles           = {"README.md", "LICENSE", "*.lua"}
typesetdemofiles    = {module .. "-*-demo.tex"}
typesetexe          = "latexmk -pdfxe -xelatex=xelatex-dev"
typesetruns         = 1
uploadconfig  = {
  announcement_file = "announcement.md",
  pkg               = module,
  version           = version .. " " .. date,
  author            = maintainer,
  uploader          = uploader,
  email             = email,
  summary           = summary,
  description       = description,
  license           = "lppl1.3c",  
  ctanPath          = "/macros/latex/contrib/" .. module,
  home              = "https://github.com/" .. maintainid,
  bugtracker        = repository .. "/issues",
  support           = repository .. "/issues",
  repository        = repository,
  development       = "https://github.com/" .. maintainid,
  update            = true
}
function update_tag(file, content, tagname, tagdate)
  tagname = version
  tagdate = date
  if string.match(file, module .. ".dtx$") then
    content = string.gsub(content,
      "%%<++!driver>\\GetIdInfo $Id: " .. module .. ".dtx " ..
      "v%d+%.%d+%.%d+ %d+%-%d+%-%d+ (.-)<(.-)>",
      "%%<+!driver>\\GetIdInfo $Id: "  .. module .. ".dtx " ..
      tagname .. " " .. tagdate .. " " .. maintainid .. "<" .. email .. ">")
  end
  return content
end

--[== "Hacks" to `l3build` | Do not Modify ==]--

function docinit_hook()
  cp(ctanreadme, unpackdir, currentdir)
  return 0
end
function tex(file,dir,cmd)
  dir = dir or "."
  cmd = cmd or typesetexe
  if os.getenv("WINDIR") ~= nil or os.getenv("COMSPEC") ~= nil then
    upretex_aux = "-usepretex=\"" .. typesetcmds .. "\""
    makeidx_aux = "-e \"$makeindex=q/makeindex -s " .. indexstyle .. " %O %S/\""
    sandbox_aux = "set \"TEXINPUTS=../local;%TEXINPUTS%;\" &&"
  else
    upretex_aux = "-usepretex=\'" .. typesetcmds .. "\'"
    makeidx_aux = "-e \'$makeindex=q/makeindex -s " .. indexstyle .. " %O %S/\'"
    sandbox_aux = "TEXINPUTS=\"../local:$(kpsewhich -var-value=TEXINPUTS):\""
  end
  return run(dir, sandbox_aux .. " " .. cmd         .. " " ..
                  upretex_aux .. " " .. makeidx_aux .. " " .. file)
end

-- %<*wu-beamer|wu-poster|wu-l3xdoc>
-- %<wu-thesis>\keys_define:nn { thesis / set }
-- %<wu-beamer>\keys_define:nn { beamer / set }
-- %<wu-poster>\keys_define:nn { poster / set }
-- %<wu-l3xdoc>\keys_define:nn { l3xdoc / set }
--   {
-- %<wu-thesis>    id        .tl_set:N   = \l_@@_set_id_tl,
-- %<wu-thesis>      id      .initial:n  = { \int_value:w \c_sys_year_int 0000000 },
--     title     .tl_set:N   = \l_@@_set_title_tl,
-- %<wu-thesis>    school    .tl_set:N   = \l_@@_set_school_tl,
-- %<wu-thesis|wu-beamer|wu-poster>    subject   .tl_set:N   = \l_@@_set_subject_tl,
--     author    .tl_set:N   = \l_@@_set_author_tl,
-- %<wu-thesis|wu-beamer|wu-poster>    PI        .tl_set:N   = \l_@@_set_PI_tl,
-- %<wu-thesis>    master    .bool_set:N = \l_@@_set_master_bool,
-- %<wu-thesis>      master  .initial:n  = false,
-- %<wu-thesis>      master  .default:n  = true,
--     bibsource .str_set:N  = \l_@@_set_bib_str,
--   }
-- %</wu-beamer|wu-poster|wu-l3xdoc>