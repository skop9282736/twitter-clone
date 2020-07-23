import consumer from "./consumer"
import CableReady from 'cable_ready'

consumer.subscriptions.create("TimelineChannel", {
  received(data) {
    console.log(data)
    if (data.cableReady) CableReady.perform(data.operations)
  }
});
