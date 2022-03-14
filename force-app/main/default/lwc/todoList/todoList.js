import { LightningElement, wire, track } from 'lwc';
import getTodoList from '@salesforce/apex/TodoController.getTodoList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { reduceErrors } from 'c/ldsUtils';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
// import ACCOUNT_OBJECT from '@salesforce/schema/Account';
// import NAME_FIELD from '@salesforce/schema/Account.Name';
import TODO_OBJECT from '@salesforce/schema/Todo__c';
import NAME_FIELD from '@salesforce/schema/Todo__c.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Todo__c.Description__c';
import CATEGORY_FIELD from '@salesforce/schema/Todo__c.Category__c';
import PRIORITY_FIELD from '@salesforce/schema/Todo__c.Priority__c';
import TITLE_FIELD from '@salesforce/schema/Todo__c.Title__c';

export default class todoList extends LightningElement {
    @wire(getTodoList) todos;

    @track isModalOpen = false;


    fields = [NAME_FIELD, TITLE_FIELD, DESCRIPTION_FIELD, CATEGORY_FIELD, PRIORITY_FIELD];


    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    todoIdEdit;
    todoId;

    name = '';

    handleNameChange(event) {
        this.todoId = undefined;
        this.name = event.target.value;
    }

    createAccount() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        const recordInput = { apiName: TODO_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then((todo) => {
                this.todoId = todo.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Todo created',
                        variant: 'success'
                    })
                );
                return refreshApex(this.todos);
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: reduceErrors(error).join(', '),
                        variant: 'error'
                    })
                );
            });
    }
    editAccount(event) {
        this.todoIdEdit = event.target.dataset.recordid;
        this.openModal();
    }
    
    deleteAccount(event) {
      const recordId = event.target.dataset.recordid;
      deleteRecord(recordId)
          .then(() => {
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Success',
                      message: 'Todo deleted',
                      variant: 'success'
                  })
              );
              return refreshApex(this.todos);
          })
          .catch((error) => {
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Error deleting record',
                      message: reduceErrors(error).join(', '),
                      variant: 'error'
                  })
              );
          });
  }
}