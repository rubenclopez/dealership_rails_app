module ApplicationHelper
  def render_link(name, path)
    is_active = 'active' if current_page?(path)

    str = <<-EOF
      <li class="#{is_active}">
        #{ link_to name, path }
      </li>
    EOF

    raw str
  end
end