var CurrentRate = React.createClass({
  getInitialState: function() {
    return { current_rate: this.props.current_rate || { value: '' }};
  },

  update: function(data) {
    this.setState({ current_rate: data });
  },

  componentDidMount: function() {
    App.current_rate = App.cable.subscriptions.create('CurrentRateChannel', {
      received: function(data){
        this.update(data.message);
      },
      update: this.update
    });
  },

  render: function() {
    return (
      <div id='current-rate' className='text-center text-vertical-center font-size-big'>
        <nobr>
          1 <abbr title={ this.state.current_rate.name }>{ this.state.current_rate.abbr }</abbr>
          &nbsp;=&nbsp;
          { this.state.current_rate.value } <abbr title="">RUB</abbr>
        </nobr>
      </div>
    );
  }
});
