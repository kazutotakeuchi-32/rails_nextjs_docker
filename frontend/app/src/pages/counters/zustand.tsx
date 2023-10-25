import Layout from "@/components/layouts/user";

import useStore  from "@/hooks/useStore";

const MAX_COUNT = 10
const MIN_COUNT = 0

const ZustandCounter = () => {
    const {bears, increment, decrement} = useStore().bearSlice()

    
    const incrementClick = () => {
        if (bears < MAX_COUNT) increment()
    }

    const decrementClick = () => {
        if (bears > MIN_COUNT) decrement()
    }


    return (
        <Layout>
            <h1>Counter: {bears}</h1>
            <button onClick={incrementClick}>
                +
            </button>
            <button onClick={decrementClick}>
                -
            </button>
        </Layout>
    )
};

export default ZustandCounter;