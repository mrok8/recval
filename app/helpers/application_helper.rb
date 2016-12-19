module ApplicationHelper
  require "redcarpet"
  require "coderay"

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.split(':')[0]

      case language.to_s
        when 'rb'
          lang = 'ruby'
        when 'yml'
          lang = 'yaml'
        when 'css'
          lang = 'css'
        when 'html'
          lang = 'html'
        when ''
          lang = 'md'
        else
          lang = language
      end

      CodeRay.scan(code, lang).div
    end
  end

  def markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: false, hard_wrap: true)
    options = {
        autolink: true,
        space_after_headers: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        tables: true,
        xhtml: true,
        lax_html_blocks: true,
        strikethrough: true,
        disable_indented_code_blocks: true,
        underline: true,
        highlight: true,
        quote: true,
        superscript: true
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end
end
