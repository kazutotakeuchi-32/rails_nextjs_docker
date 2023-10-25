import {create} from 'zustand';
import BearSlice from "./bearSlice";

const BaseStore = create(()=>({
    bearSlice: BearSlice,
}));

export default BaseStore;

