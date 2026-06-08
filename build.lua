--[==========================================================================[--
    L3BUILD FILE FOR WESTLAKETHESIS              Copyright (C) by Mingyu Xia
--]==========================================================================]--

--[==========================================================================[--
    Basic Information: Do Check Before Push
--]==========================================================================]--
module              = "westlakethesis"
version             = "v0.0.1"
date                = "2026-06-18"
maintainer          = "Mingyu Xia"
uploader            = "Mingyu Xia"
maintainid          = "myhsia"
email               = "myhsia@outlook.com"
repository          = "https://github.com/" .. maintainid .. "/" .. module
summary             = "LaTeX bundle for Westlake University dissertations."
description         = "The `WESTLAKEthesis` is a LaTeX bundle for Westlake University dissertations, including Ph.D. thesis and Beamer theme."


--[==========================================================================[--
    Configuration: Check, Tag, Pack, Upload     Do NOT Modify if Unnecessary
--]==========================================================================]--
checkengines        = {"xetex", "uptex"}
cleanfiles          = {"*.log", "*.pdf", "*.zip", "*.curlopt"}
ctanzip             = module
excludefiles        = {"*~"}
installfiles        = {"*.sty", "*.cls", "*.code.tex", "*.pdf", "*.png"}
sourcefiles         = {"*.dtx", "*.ins", "./media/*.pdf", "./media/*.png"}
textfiles           = {"README.md", "LICENSE", "*.lua"}
typesetdemofiles    = {module .. "-*-demo.tex"}
typesetexe          = "latexmk -pdfxe -xelatex=xelatex-dev"
typesetruns         = 1
specialtypesetting  = specialtypesetting or {}
specialtypesetting["westlakethesis-pre-demo.tex"]
                    = {cmd = "latexmk -pdf -pdflatex=pdflatex-dev"}
uploadconfig  = {
  note              = "",
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

--[================== "Hacks" to `l3build` | Do not Modify ==================]--
function docinit_hook()
  run(typesetdir, "curl -O -L " ..
    "\"https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-CN-unhinted.zip\"")
  run(typesetdir, "unzip MapleMono-CN-unhinted.zip")
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
