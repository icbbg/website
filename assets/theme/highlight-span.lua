return {
  Span = function(el)
    local highlight = el.attr.classes[1] == "highlight"

    -- if no red attribute, return unchange
    if highlight == false then
      return el
    end

    -- transform to <span style="color: red;"></span>
    if FORMAT:match("html") then
      -- remove color attributes
      el.attributes["color"] = nil
      -- use style attribute instead
      el.attributes["style"] = "color: " .. "#8c1d40" .. ";"
      -- return full span element
      return el
    elseif FORMAT:match("latex") then
      -- remove color attributes
      el.attributes["color"] = nil
      -- encapsulate in latex code
      table.insert(el.content, 1, pandoc.RawInline("latex", "\\textcolor{" .. "red" .. "}{"))
      table.insert(el.content, pandoc.RawInline("latex", "}"))
      -- returns only span content
      return el.content
    else
      -- for other format return unchanged
      return el
    end
  end,
}
