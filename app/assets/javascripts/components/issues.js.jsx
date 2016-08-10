var Issues = React.createClass({
  propTypes: {
    title: React.PropTypes.string,
    url: React.PropTypes.string,
    labels: React.PropTypes.array
  },

  render: function() {
    return (
      <table class="table">
        <thead>
          <tr>
            <th>Title</th>
            <th>Url</th>
            <th>Labels</th>
            <th>Project</th>
          </tr>
        </thead>
      <tbody>
        { this.props.data.map( function(issue) {
            return (
              <tr key={issue.id}>
                <td>{issue.title}</td>
                <td>{issue.url}</td>
                <td>{issue.labels}</td>
              </tr>
            )
          })
        }
      </tbody>
    </table>
    );
  }
});
