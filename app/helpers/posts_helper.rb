module PostsHelper
    def likers_of(post)
        votes = post.votes_for.up.by_type(User)
        user_names = []
        unless votes.blank?
          votes.voters.each do |voter|
            user_names.push(link_to voter.username, user_path(voter))
          end
          user_names.to_sentence.html_safe + like_plural(votes)
        end
    end
    
    private

    def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
    end
end
