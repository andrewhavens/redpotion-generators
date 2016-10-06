Feature: Scaffold Generator
  Scenario: Generating Scaffold
    When I run `rp scaffold blog_post title:string body:text published:boolean publish_date:datetime`
    Then the output should contain exactly:
    """
          create  app/models/blog_post.rb
          create  schemas/0001_create_blog_post.rb
          create  app/screens/blog_posts_screen.rb
          create  app/screens/new_blog_post_screen.rb
          create  app/screens/blog_post_detail_screen.rb
          create  app/screens/edit_blog_post_screen.rb
          create  app/stylesheets/blog_posts_screen_stylesheet.rb
          create  app/stylesheets/blog_post_form_screen_stylesheet.rb
          create  app/stylesheets/blog_post_detail_screen_stylesheet.rb
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
              title: "Blog Post ##{blog_post.id}",
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
    And the file "app/screens/new_blog_post_screen.rb" should contain exactly:
    """
    class NewBlogPostScreen < PM::XLFormScreen
      title "New Blog Post"
      stylesheet BlogPostFormScreenStylesheet

      form_options required:  :asterisks, # add an asterisk to required fields
                   on_save:   :'save_form:', # will be called when you touch save
                   on_cancel: :cancel_form, # will be called when you touch cancel
                   auto_focus: true # the form will focus on the first focusable field

      def form_data
        [{
          cells: [
            {
              title: "Title",
              name: :title,
              type: :string
            },
            {
              title: "Body",
              name: :body,
              type: :text
            },
            {
              title: "Published",
              name: :published,
              type: :check
            },
            {
              title: "Publish Date",
              name: :publish_date,
              type: :datetime
            },
          ]
        }]
      end

      def save_form(values)
        dismiss_keyboard
        BlogPost.create(values)
        app.data.save
        close
      end

      def cancel_form
        close
      end

      # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
      # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
      #   def logo(st)
      #     st.frame = {t: 10, w: 200, h: 96}
      #     st.centered = :horizontal
      #     st.image = image.resource('logo')
      #     st.tag(:reapply_style)
      #   end
      #
      # Then in will_animate_rotate
      #   find(:reapply_style).reapply_styles#

      # Remove the following if you're only using portrait
      def will_animate_rotate(orientation, duration)
        reapply_styles
      end
    end
    """
    And the file "app/screens/blog_post_detail_screen.rb" should contain exactly:
    """
    class BlogPostDetailScreen < PM::Screen
      title "Blog Post"
      stylesheet BlogPostDetailScreenStylesheet

      attr_accessor :blog_post

      def on_load
        set_nav_bar_button :right, title: "Edit", action: :edit_blog_post
        append(UILabel, :title).data("Title: #{blog_post.title}")
        append(UILabel, :body).data("Body: #{blog_post.body}")
        append(UILabel, :published).data("Published: #{blog_post.published}")
        append(UILabel, :publish_date).data("Publish Date: #{blog_post.publish_date}")
      end

      def edit_blog_post
        open EditBlogPostScreen.new(blog_post: blog_post)
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
    And the file "app/screens/edit_blog_post_screen.rb" should contain exactly:
    """
    class EditBlogPostScreen < PM::XLFormScreen
      title "Edit Blog Post"
      stylesheet BlogPostFormScreenStylesheet

      attr_accessor :blog_post

      form_options required:  :asterisks, # add an asterisk to required fields
                   on_save:   :'save_form:', # will be called when you touch save
                   on_cancel: :cancel_form, # will be called when you touch cancel
                   auto_focus: true # the form will focus on the first focusable field

      def form_data
        [{
          cells: [
            {
              title: "Title",
              name: :title,
              type: :string,
              value: blog_post.title
            },
            {
              title: "Body",
              name: :body,
              type: :text,
              value: blog_post.body
            },
            {
              title: "Published",
              name: :published,
              type: :check,
              value: blog_post.published
            },
            {
              title: "Publish Date",
              name: :publish_date,
              type: :datetime,
              value: blog_post.publish_date
            },
          ]
        }]
      end

      def save_form(values)
        dismiss_keyboard
        blog_post.update(values)
        app.data.save
        close(blog_post: blog_post)
      end

      def cancel_form
        close
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
    And the file "app/stylesheets/blog_post_detail_screen_stylesheet.rb" should contain exactly:
    """
    class BlogPostDetailScreenStylesheet < ApplicationStylesheet
      # Add your view stylesheets here. You can then override styles if needed,
      # example: include FooStylesheet

      def setup
        # Add stylesheet specific setup stuff here.
        # Add application specific setup stuff in application_stylesheet.rb
      end

      def root_view(st)
        st.background_color = color.white
      end

      def title(st)
        nav_bar_height = 64 # First element is below the nav bar
        st.frame = { t: nav_bar_height, w: :full, h: 44, padding: 10 }
      end

      def body(st)
        st.frame = { bp: 0, w: :full, h: 44, padding: 10 }
      end

      def published(st)
        st.frame = { bp: 0, w: :full, h: 44, padding: 10 }
      end

      def publish_date(st)
        st.frame = { bp: 0, w: :full, h: 44, padding: 10 }
      end
    end
    """
