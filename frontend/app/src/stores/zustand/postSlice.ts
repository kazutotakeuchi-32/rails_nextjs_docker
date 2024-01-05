import { create } from "zustand";
import {Post, Input} from "@/types/post";

export interface PostState {
    list: Post[];
    row: Post | null;
    loading: boolean;
    init: () => void;
    getAllAsync: () => Promise<void>;
    getOneAsync: (id: number) => Promise<void>;
    PostAsync: (params: Input) => Promise<void>;
    deleteAsync: (id: number) => Promise<void>;
    updateAsync: ( params: Input & {id: number}) => Promise<void>;
}

const PostSlice = create<PostState>((set) => ({
    list: [],
    row: null,
    loading: false,
    init: () => set({list: []}),
    getAllAsync: async () => {
        set({loading: true});
        const res = await fetch("http://localhost:3000/api/post");
        const data = await res.json();
        set({list: data, loading: false});
    },
    getOneAsync: async (id) => {
        set({loading: true});
        const res = await fetch(`http://localhost:3000/api/post/${id}`);
        const data = await res.json();
        set({row: data, loading: false});
    },
    PostAsync: async (params) => {
        set({loading: true});
        const res = await fetch(`http://localhost:3000/api/post`, {
            method: "POST",
            body: JSON.stringify(params),
            headers: {
                "Content-Type": "application/json",
            },
        });
        const data = await res.json();
        set({row: data, loading: false});
    },
    deleteAsync: async (id) => {
        set({loading: true});
        await fetch(`http://localhost:3000/api/post/${id}`, {
            method: "DELETE",
        });
        set({loading: false});
    },
    updateAsync: async (params) => {
        set({loading: true});
        const res = await fetch(`http://localhost:3000/api/post/${params.id}`, {
            method: "PUT",
            body: JSON.stringify(params),
            headers: {
                "Content-Type": "application/json",
            },
        });
        const data = await res.json();
        set({row: data, loading: false});
    },

}))


export default PostSlice;
