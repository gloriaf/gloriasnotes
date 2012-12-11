
module NavigationHelpers

  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the new topic page/
      new_topic_path
    when /^the topic list page/
      topics_path
    when /^the show page for "([^"]*)"$/
      topic_path(Topic.find_by_name($1).id)
    when /^the edit page for "([^"]*)"$/
      edit_topic_path(Topic.find_by_name($1).id)
    when /^the new page/
      '/topics'
    when /^the new page/
      '/topics'
    when /^the notes page for "([^"]*)"$/
      topic_notes_path(Topic.find_by_name($1).id)
    when /^the new note page for "([^"]*)"$/
      topic=Topic.find_by_name($1)
      new_topic_note_path(topic)
    when /^the show note page for note "([^"]*)" and "([^"]*)"$/
      topic=Topic.find_by_name($2)
      note=topic.notes.find_by_sequence($1)
      topic_note_path(topic, note)
    when /^the edit note page for note "([^"]*)" and "([^"]*)"$/
      topic=Topic.find_by_name($2)
      note=topic.notes.find_by_sequence($1)
      edit_topic_note_path(topic, note)
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
