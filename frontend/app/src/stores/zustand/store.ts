import { create } from "zustand";
import PostSlice from "./postSlice";
import BearSlice from "./bearSlice";

const BaseStore = create(() => ({
    postSlice: PostSlice,
    bearSlice: BearSlice,
}))

export default BaseStore;
