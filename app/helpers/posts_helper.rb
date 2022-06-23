module PostsHelper

    def display_likes(post)
      votes = post.votes_for.up.by_type(User)
      return list_likers(votes) if votes.size <= 4
      count_likers(votes)
    end

    def liked_post(post)
      return 'like_fill' if current_user.voted_for? post
      'like_non_fill'
    end
    
    private

    def list_likers(votes)
      user_names = []
      unless votes.blank?
        votes.voters.each do |voter|
          user_names.push(link_to voter.username, user_path(voter))
        end
        user_names.to_sentence(two_words_connector: ' и ', words_connector: ', ', last_word_connector: ' и ').html_safe + ' поставили отметки "Нравится"'
      end
    end

    def count_likers(votes)
      vote_count = votes.size
      vote_count.to_s + ' отметок "Нравится"'
    end
end
