Feature: CDQ Model Generator
  Scenario: Generating a CDQ Model for the first time
    When I run `rp cdq_model blog_post title:string body:text published:datetime`
    Then the output should contain exactly:
    """
          create  app/models/blog_post.rb
          create  schemas/0001_create_blog_post.rb
    """
    And the file "app/models/blog_post.rb" should contain:
    """
    class BlogPost < CDQManagedObject
    end
    """
    And the file "schemas/0001_create_blog_post.rb" should contain exactly:
    """
    schema "0001 Create BlogPost" do
      entity "BlogPost" do
        string :title
        text :body
        datetime :published
      end
    end
    """

  Scenario: Generating a CDQ Model when previous schemas exist
    Given a file named "schemas/0001_create_blog_post.rb" with:
    """
    schema "0001 Create BlogPost" do
      entity "BlogPost" do
        string :title, optional: false
        text :body
        datetime :published
      end
    end
    """
    And a file named "schemas/0002_create_comment.rb" with:
    """
    schema "0002 Create Comment" do
      entity "BlogPost" do
        string :title, optional: false
        text :body
        datetime :published
      end

      entity "Comment" do
        string :body, optional: false
      end
    end
    """
    When I run `rp cdq_model author name:string blog_posts:has_many`
    Then the output should contain exactly:
    """
          create  app/models/author.rb
          create  schemas/0003_create_author.rb
    """
    And the file "schemas/0003_create_author.rb" should contain exactly:
    """
    schema "0003 Create Author" do
      entity "BlogPost" do
        string :title, optional: false
        text :body
        datetime :published
      end

      entity "Comment" do
        string :body, optional: false
      end

      entity "Author" do
        string :name
        has_many :blog_posts
      end
    end
    """
