import { LightningElement, api, track } from "lwc";

/**
 * Show an item
 */
export default class todoItem extends LightningElement {
  @api
  todo = {};
}