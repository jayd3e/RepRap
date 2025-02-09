<%inherit file="../layouts/base.mako"/>

<%def name="body()">
    <div class="content_column">
        <h1>View Issue</h1>
        <div class="image_gallery">
            <div class="image_slide">
            % for image in issue.images:
                <div class="image">
                    <img width="300" height"300" src="/static/img/issue_images/${image.directory}/tile.jpeg" />
                </div>
            % endfor
            </div>
            <div class="left_arrow" onClick="javascript: slide(this, 'left');">
            </div>
            <div class="right_arrow" onClick="javascript: slide(this, 'right');">
            </div>
        </div>
        <div class="issue">
            <h1>${issue.title}</h1>
            <span>Created On: ${issue.created.strftime('%B %d, %Y')}</span>
            <p>${issue.description}</p>
        </div>
        <div class="add_comment">
            <h1>Comments</h1>
            ${add_issue_comment_form | n}
        </div>
        <div class="comments">
            % for comment in issue.comments:
                <%
                user_id = 1
                up = "up"
                down = "down"
                vote = ""

                for users_comments in issue.user.users_comments:
                    if user_id == users_comments.user_id and comment.id == users_comments.comment_id:
                        vote = users_comments.vote
                        if vote == 1:
                            up = up + " active"
                        elif  vote == -1:
                            down = down + " active"
                        break
                    else:
                        continue
                %>
                <div class="comment">
                    <div class="comment_body">
                        <a href="#">${issue.user.username}</a><span> ${comment.created.strftime('%B %d, %Y')}</span>
                        <p>${comment.body}</p>
                    </div>
                    <div class="comment_score">${comment.score}</div>
                    <div class="comment_rate">
                        <div class="${up}" onClick="javascript: toggle_vote(this, ${user_id}, ${comment.id}, 'up');"></div>
                        <div class="${down}" onClick="javascript: toggle_vote(this, ${user_id}, ${comment.id}, 'down');"></div>
                    </div>
                </div>
            % endfor
        </div>
    </div>
    <div class="action_column">
        <div class="action">
            <h1>Tags</h1>
            <ul class="tags">
            <%
            from reprap.utils import trunc
            %>
            % for tag in issue.tags:
                <li>
                    <a href="/tags/${tag.id}">${trunc(tag.name, max_pos=21)}</a>
                </li>
            % endfor
            </ul>
            ${add_tag_form | n}
        </div>
        <div class="action">
            <h1>ACTIONS</h1>
            <a href="/issues/add">Add Issue</a>
        </div>
    </div>
</%def>