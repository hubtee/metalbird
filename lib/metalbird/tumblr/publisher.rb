module Metalbird
  module Tumblr
    class Publisher
      def initialize(auth)
        @client = auth.client
      end

      def publish(blog_name, post)
        result = @client.text(blog_name, post)

        {
          blog_name: blog_name,
          content: post,
          id: result['id']
        }

      rescue => error
        puts error
      end
    end
  end
end
