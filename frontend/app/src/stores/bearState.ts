import {create} from "zustand";

interface BearState {
    bears: number;
    increment: () => void;
    decrement: () => void
    init: () => void;

}

const useBearStore = create<BearState>()((set) => ({
    bears: 0,
    increment: () => set(state => ({bears: state.bears + 1})),
    decrement: () => set(state => ({bears: state.bears - 1})),
    init: () => set({bears: 0}),
}))




export default useBearStore;
