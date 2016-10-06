Feature: CDQ Table Screen Generator
  Scenario: Generating a CDQ Table Screen
    When I successfully run `rp cdq_table_screen blog_posts`
    Then the output should contain exactly:
    """
          create  app/stylesheets/blog_posts_screen_stylesheet.rb
          create  app/screens/blog_posts_screen.rb
    """
    And the file "app/screens/blog_posts_screen.rb" should contain exactly:
    """
    class BlogPostsScreen < PM::TableScreen
      title "Blog Posts"
      stylesheet BlogPostsScreenStylesheet

      def on_load
        set_nav_bar_button :right, title: "New", action: :new_blog_post
      end

      def new_blog_post
        open NewBlogPostScreen
      end

      def on_return(args = {})
        update_table_data if args[:todo]
      end

      def table_data
        [{
          cells: BlogPost.all.map do |blog_post|
            # For full list of options, refer to (insert ProMotion docs link here)
            {
              title: "Blog Posts ##{blog_post.id}",
              # subtitle: "Optional Subtitle",
              action: :show_blog_post,
              arguments: { blog_post: blog_post },
              editing_style: :delete
            }
          end
        }]
      end

      def show_blog_post(args)
        open BlogPostDetailScreen.new(args)
      end

      def on_cell_deleted(cell, index_path)
        cell[:arguments][:blog_post].destroy
        app.data.save
      end

      # You don't have to reapply styles to all UIViews. If you want to optimize,
      # another way to do it is to tag the views you need to restyle in your stylesheet,
      # then only reapply the tagged views. For example:
      #   def logo(st)
      #     st.frame = {t: 10, w: 200, h: 96}
      #     st.centered = :horizontal
      #     st.image = image.resource('logo')
      #     st.tag(:reapply_style)
      #   end
      #
      # Then in will_animate_rotate
      #   find(:reapply_style).reapply_styles

      # Remove the following if you're only using portrait
      def will_animate_rotate(orientation, duration)
        reapply_styles
      end
    end
    """
