export class MessageModel {
    id: number;
    senderId:number;
    receiverId:number;
    content:string;
    timeStamp:Date;
    isAdmin:boolean;
}