module ApplicationHelper
  def markdown_to_html(markdown)
    render_options = { prettify: true }
    extensions = { autolink: true, highlight: true }
    renderer = Redcarpet::Render::HTML.new(render_options)
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end
end
